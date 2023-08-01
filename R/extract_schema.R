#' Load XML Schema
#'
#' @param file_path Path to XML schema file.
#' @export
#' @examples
#'
#' xml_schema <- load_xml(xml_file = "~/path/to/schema.xml")
load_xml <- function(xml_file) {
  raw_xml <- xml2::read_xml(xml_file)
  return(raw_xml)
}

#' Extract Types
#'
#' Extract different types of data elements from the XML Schema.
#'
#' @param xml_file XML file to be parsed.
#' @param type Type of element to extract from the schema. TRUD defines the following options which are selected by the
#' noted code.
#'
#' @export
#' @examples
#' types <- extract_structure("data/xml/ecds/ecdsxml/CDS_011_Emergency_Care-V4-0.xsd")
extract_structure <- function(xml_file) {
  xml <- load_xml(xml_file)
  types <- vector(mode = "list", length = 2)
  names(types) <- c("simple", "complex")
  types$complex <- xml2::xml_find_all(xml, "//xs:complexType", flatten = FALSE)
  types$simple <- xml2::xml_find_all(xml, "//xs:simpleType", flatten = FALSE)
  types
}


#' Extract information from simple data types.
#'
#' @param x list List of simple XML schema extracted using extract_structure
#'
#' @returns
#' @export
#' @examples
#'
#' types <- extract_structure("path/to/xml_schema.xsd")
#' simple_info <- extract_info_simple(types$simple)
#' names(simple_info)
extract_info_simple <- function(x) {
  properties <- vector(mode = "list", length = 8)
  names(properties) <- c(
    "name", "min_length", "max_length", "length", "min_inclusive", "max_inclusive",
    "enumeration_values", "pattern_values"
  )
  properties$name <- xml2::xml_attr(x, "name")
  restrictions <- xml2::xml_find_all(x, ".//xs:restriction")
  base <- xml2::xml_attr(restrictions, attr = "base")
  min_length <- xml2::xml_find_all(restrictions, ".//xs:minLength", flatten = FALSE)
  properties$min_length <- lapply(min_length, xml2::xml_attr, "value") |> as.vector("numeric")
  max_length <- xml2::xml_find_all(restrictions, ".//xs:maxLength", flatten = FALSE)
  properties$max_length <- lapply(max_length, xml2::xml_attr, "value") |> as.vector("numeric")
  length <- xml2::xml_find_all(restrictions, ".//xs:length", flatten = FALSE)
  properties$length <- lapply(length, xml2::xml_attr, "value") |> as.vector("numeric")
  min_inclusive <- xml2::xml_find_all(x, ".//xs:minInclusive", flatten = FALSE)
  properties$min_inclusive <- lapply(min_inclusive, xml2::xml_attr, "value") |> as.vector("numeric")
  max_inclusive <- xml2::xml_find_all(x, ".//xs:maxInclusive", flatten = FALSE)
  properties$max_inclusive <- lapply(max_inclusive, xml2::xml_attr, "value") |> as.vector("numeric")
  enumerations <- xml2::xml_find_all(restrictions, ".//xs:enumeration", flatten = FALSE)
  properties$enumeration_values <- lapply(enumerations, xml2::xml_attr, "value") |> as.vector()
  patterns <- xml2::xml_find_all(restrictions, ".//xs:pattern", flatten = FALSE)
  properties$pattern_values <- lapply(patterns, xml2::xml_attr, "value") |> as.vector()
  return(properties)
}

#' Create a simple ruleset conditional on the values for a given variable
#'
#' @param x List A list of lists extracted
#' @export
#' @examples
#' types <- extract_structure("path/to/xml_schema.xsd")
#' simple_info <- extract_info_simple(types$simple)
#' create_simple_ruleset(simple_info)
create_simple_ruleset <- function(x) {
  ## Check lists are all the same length
  list_lengths <- as.vector(sapply(x, length))
  stopifnot(min(list_lengths) == max(list_lengths))
  rules <- list()
  for (i in seq_along(x$name)) {
    rules[i] <- create_simple_rule(
      name = x$name[i],
      min_length = x$min_length[i],
      max_length = x$max_length[i],
      length = x$length[i],
      min_inclusive = x$min_inclusive[i],
      max_inclusive = x$max_inclusive[i],
      enumeration_values = x$enumeration_values[i],
      pattern_values = x$pattern_values[i]
    )
  }
  rules
}

#' Create a simple rule from the extracted information conditional on what values are present.
#'
#' @param name str Name of variable from XML Schema
#' @param min_length int Minimum length of variable, may be NA.
#' @param max_length int Maximum length of variable, may be NA.
#' @param length int Length of variable, may be NA.
#' @param min_inclusive int Minimum value (inclusive) a value may take.
#' @param max_inclusive int Maximum value (inclusive) a value may take.
#' @param enumerations list List of possible enumerations for a categorical variable.
#' @param patterns list List of possible patterns for a variable.
#' @export
#'
create_simple_rule <- function(name,
                               min_length,
                               max_length,
                               length,
                               min_inclusive,
                               max_inclusive,
                               enumeration_values,
                               pattern_values) {
  print(paste0("enumeration_values    : ", enumeration_values[[1]]))
  print(paste0("!is.null(enumeration_values)  : ", !is.null(enumeration_values)))
  print(paste0("length(enumeration_values[[1]]) > 0 : ", length(enumeration_values[[1]]) > 0))
  if (!is.na(min_length) && !is.na(max_length)) {
    print("Making a MIN MAX rule")
    min_max_rule <- create_min_max_rule(name, min_length, max_length)
    print(min_max_rule)
    min_max_rule
  } else if (is.na(min_length) && !is.na(max_length)) {
    print("Making a LENGTH rule")
    length_rule <- create_length_rule(name, max_length)
    print(length_rule)
    length_rule
  } else if (!is.null(enumeration_values) && length(enumeration_values[[1]]) > 0) {
    print("Making a CATEGORICAL rule")
    categorical_rule <- create_categorical_rule(name, enumeration_values)
    categorical_rule
  } else if (!is.null(pattern_values) && length(pattern_values[[1]]) > 0) {
    print("Making a PATTERN rule")
    pattern_rule <- create_categorical_rule(name, pattern_values)
    pattern_rule
  }
}

#' Create a min/max rule for string variables.
#'
#' Ensures the length of a string is greater than the minimum and less than the maxium.
#'
#' @param name Str Name of variable rule pertains to.
#' @param min_length int Minimum number of characters in a string variable.
#' @param max_length int Maximum number of charactesr in a string variable.
#' @export
#' @examples
#'
#' create_min_max_rule("forename", min_length = 1, max_length = 20)
create_min_max_rule <- function(name, min_length, max_length) {
  col <- as.symbol(name)
  colname <- eval(name)
  dataverifyr::rule(.(col) >= .(min_length) && .(col) <= .(max_length),
    name = .(colname),
    allow_na = TRUE
  ) |>
    bquote() |>
    evalq()
}

#' Create a maximum length rule for string variables.
#'
#' Ensures the length of a string variable matches the specified length.
#'
#' @param name str Name of variable rule pertains to.
#' @param var_length int Number of characters in a string variable.
#' @export
#' @examples
#'
#' create_length_rule("arbitrary_id", 20)
create_length_rule <- function(name, var_length) {
  col <- as.symbol(name)
  colname <- eval(name)
  dataverifyr::rule(.(col) < .(var_length),
    name = .(colname),
    allow_na = TRUE
  ) |>
    bquote() |>
    evalq()
}

#' Create a rule for categorical variables.
#'
#' @param name str Name of variable rule is being created for.
#' @param enumerate list List of possible values a variable can take.
#' @export
#' @examples
#'
#' create_categorical_rule("arbitrary_binary", c("Y", "N"))
create_categorical_rule <- function(name, values) {
  col <- as.symbol(name)
  colname <- eval(name)
  dataverifyr::rule(.(col) %in% .(values),
    name = .(colname),
    allow_na = TRUE
  ) |>
    bquote() |>
    evalq()
}

#' Create a pattern rule for variables.
#'
#' @param name str Name of variable rule is being created for.
#' @param x str Regular expression rule.
#' @export
#' @examples
#'
#' create_pattern_rule("arbitrary_variable", "[0-9]*")
create_pattern_rule <- function(name, pattern) {
  col <- as.symbol(name)
  colname <- eval(name)
  dataverifyr::rule(col == regexpr(pattern),
    name = .(colname),
    allow_na = TRUE
  ) |>
    bquote() |>
    evalq()
}

#' Write a ruleset to YAML file.
#'
#' If the specified directory path doesn't exist it will be created.
#'
#' @param x list ruleset created by create_simple_ruleset() or create_complex_ruleset().
#' @param output_dir str Directory to save YAML file to.
#' @param yaml_file str Name of YAML file rules are to be written to under output_dir, defaults to 'rules.yaml'
#' @export
#' @examples
write_rules_to_yaml <- function(x, output_dir = "./", yaml_file = "rules.yaml") {
  if (!dir.exists(file.path(output_dir))) {
    dir.create(output_dir)
  }
  dataverifyr::write_rules(x, file.path(output_dir, yaml_file))
}

#' Extract information from complex data types.
#'
#' @param x list List of complex XML schema extracted using extract_structure
#' @export
#' @examples
#'
#' types <- extract_structure("path/to/xml_schema.xsd")
#' complex_info <- extract_info_complex(types$complex)
#' names(complex_info)
extract_info_complex <- function(x) {
}
