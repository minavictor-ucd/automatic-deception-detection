#-------------------------------------------------------------------------------------------------------------
# File:        add-fext.r
# Description: Features extration for single observation automated deception detection using R NLP packages
#-------------------------------------------------------------------------------------------------------------

#-------------------------------------------------------------------------------------------------------------
# Package required
#-------------------------------------------------------------------------------------------------------------
#install.packages(c("NLP", "openNLP", "RWeka", "qdap", "rJava"))
library(rJava)
library(NLP)
library(openNLP)
library(RWeka)
library(stringi)

#-------------------------------------------------------------------------------------------------------------
# Global object(s)
#-------------------------------------------------------------------------------------------------------------
#-- Annotators objects
sentence_annotator <- Maxent_Sent_Token_Annotator()
word_annotator <- Maxent_Word_Token_Annotator()
pos_tag_annotator <- Maxent_POS_Tag_Annotator()
location_annotator <- Maxent_Entity_Annotator(kind = "location")
organization_annotator <- Maxent_Entity_Annotator(kind = "organization")
percentage_annotator <- Maxent_Entity_Annotator(kind = "percentage")
person_annotator <- Maxent_Entity_Annotator(kind = "person")

#-------------------------------------------------------------------------------------------------------------
# Helpers
#-------------------------------------------------------------------------------------------------------------

# Get the total number of a given annotator, if found. Or 0 otherwise.
get_annotation_count <- function(annotator, raw_text_observation, text_observation_annotations) {
  result = tryCatch({
    length(raw_text_observation[annotator(raw_text_observation, text_observation_annotations)])
  }, warning = function(w) { return(0) }, error = function(e) { return(0) }
  )
  return(result)
}

# Get the total number of a given annotator, if found. Or 0 otherwise.
get_total_characters_count <- function(raw_text_observation) {
  return(stri_length(stri_replace_all_charclass(raw_text_observation, "\\p{WHITE_SPACE}", "")))
}

# Get the total number of digits
get_total_digits_count <- function(raw_text_observation) {
  digits_pattern <- paste(c(0:9), collapse = "|")
  digits_count <- nrow(stri_match_all(raw_text_observation, regex = digits_pattern, omit_no_match = TRUE)[[1]])
  return(digits_count)
}

# Get the total number of punctuations
get_total_punctuations_count <- function(text_observation_words_tokens) {
  punctuation_pattern <- c(".", "?", "!", ":", ";", "-", "(", ")", "[", "]", "...", "’", '"', "/", ",")
  matched = match(text_observation_words_tokens, punctuation_pattern)
  matched <- matched[!is.na(matched)] # Removing NA
  return (length(matched))
}

# Get the total numnber of 1 person singular pronouns 
get_first_person_singular_pronouns_count <- function(text_observation_words_tokens) {
  first_person_singular_pronouns <- c( "I", "me", "my", "mine")
  matched = match(text_observation_words_tokens, first_person_singular_pronouns)
  matched <- matched[!is.na(matched)] # Removing NA
  return (length(matched))
}

# Get the total numnber of 1 person plural pronouns 
get_first_person_plural_pronouns_count <- function(text_observation_words_tokens) {
  first_person_plural_pronouns <- c("our", "ours", "we", "us")
  matched = match(text_observation_words_tokens, first_person_plural_pronouns)
  matched <- matched[!is.na(matched)] # Removing NA
  return (length(matched))
}

# Get the total numnber of 2 person singular pronouns 
get_Second_person_singular_pronouns_count <- function(text_observation_words_tokens) {
  second_person_singular_pronouns <- c( "you", "your")
  matched = match(text_observation_words_tokens, second_person_singular_pronouns)
  matched <- matched[!is.na(matched)] # Removing NA
  return (length(matched))
}

# Get the total numnber of 2 person plural pronouns 
get_second_person_plural_pronouns_count <- function(text_observation_words_tokens) {
  second_person_plural_pronouns <- c("you", "your", "yours")
  matched = match(text_observation_words_tokens, second_person_plural_pronouns)
  matched <- matched[!is.na(matched)] # Removing NA
  return (length(matched))
}


# Get the total numnber of 2 person pronouns 
get_second_person_pronouns_count <- function(text_observation_words_tokens) {
  second_person_pronouns <- c("you", "your", "yours")
  matched = match(text_observation_words_tokens, second_person_pronouns)
  matched <- matched[!is.na(matched)] # Removing NA
  return (length(matched))
}

# Get the total numnber of 3 person singular pronouns 
get_first_person_singular_pronouns_count <- function(text_observation_words_tokens) {
  third_person_singular_pronouns <- c( "he", "she", "it", "him", "her", "his", "hers", "its")
  matched = match(text_observation_words_tokens, third_person_singular_pronouns)
  matched <- matched[!is.na(matched)] # Removing NA
  return (length(matched))
}

# Get the total numnber of 3 person plural pronouns 
get_third_person_plural_pronouns_count <- function(text_observation_words_tokens) {
  third_person_plural_pronouns <- c("they", "them", "thier", "thiers")
  matched = match(text_observation_words_tokens, third_person_plural_pronouns)
  matched <- matched[!is.na(matched)] # Removing NA
  return (length(matched))
}

# Get the total numnber of 3 person plural pronouns 
get_possessive_pronouns_count <- function(text_observation_words_tokens) {
  possessive_pronouns <- c("my", "mine", "our", "ours")
  matched = match(text_observation_words_tokens, possessive_pronouns)
  matched <- matched[!is.na(matched)] # Removing NA
  return (length(matched))
}

# Get the POS distribution of given text observation
getPOS <- function(text_observations) {  
  annotation_stmts_wrds <- annotate(text_observations, list(sentence_annotator, word_annotator))
  annotation_POS <- annotate(text_observations, pos_tag_annotator, annotation_stmts_wrds)
  
  annotation_POS_wrods <- subset(annotation_POS, type == "word")
  observation_tags_dist <- table(sapply(annotation_POS_wrods$features, `[[`, "POS"))
  tag <- "CD"
  class(observation_tags_dist[tag])
  
  POS_tags = c("CC", "CD", "DT", "EX", "FW", "IN", "JJ", "JJR", "JJS", "LS", "MD", "NN", "NNS", "NNP", "NNPS", "PDT", "POS", "PRP", "PRP$", "RB", "RBR", "RBS", "RP", "SYM", "TO", "UH", "VB", "VBD", "VBG", "VBN", "VBP", "VBZ", "WDT", "WP", "WP$", "WRB")
  final_observation_tags_dist <- vector(mode="numeric", length=length(POS_tags))
  names(final_observation_tags_dist) <- POS_tags
  
  for (idx in 1:length(POS_tags)) {
    tag <- POS_tags[idx]
    if (!is.na(observation_tags_dist[tag])) {
      final_observation_tags_dist[tag] <- observation_tags_dist[tag]
    }
  }
  
  names(final_observation_tags_dist) <- paste("POS_",names(final_observation_tags_dist), sep="")
  return (final_observation_tags_dist)
}

#-------------------------------------------------------------------------------------------------------------
# API
#-------------------------------------------------------------------------------------------------------------
# Extract features using NLP RPackage
deception_features_extractor_r_nlp <- function(raw_text_observation) {  
  # Flatten and convert to String.
  raw_text_observation <- paste(raw_text_observation, collapse = " ")
  raw_text_observation <- as.String(raw_text_observation)
  raw_text_observation <- tolower(raw_text_observation)
  
  pipeline_annotator <- list(sentence_annotator, word_annotator, location_annotator, organization_annotator, percentage_annotator, person_annotator)
  text_observation_annotations <- annotate(raw_text_observation, pipeline_annotator)
  
  # Combine text observation and annotation in a doc
  text_observation_doc <- AnnotatedPlainTextDocument(raw_text_observation, text_observation_annotations)
  
  words_tokens <- raw_text_observation[word_annotator(raw_text_observation, text_observation_annotations)]
  
  ##-- Quantative cues
  WordsCount <- get_annotation_count(word_annotator, raw_text_observation, text_observation_annotations)
  StatementsCount <- get_annotation_count(sentence_annotator, raw_text_observation, text_observation_annotations)
  CharactersCount <- get_total_characters_count(raw_text_observation)
  DigitsCount <- get_total_digits_count(raw_text_observation)
  
  #-- References cues
  LocationsCount <- get_annotation_count(location_annotator, raw_text_observation, text_observation_annotations)
  OrganizationsCount <- get_annotation_count(organization_annotator, raw_text_observation, text_observation_annotations)
  PercentagesCount <- get_annotation_count(percentage_annotator, raw_text_observation, text_observation_annotations)
  PersonsCount <- get_annotation_count(person_annotator, raw_text_observation, text_observation_annotations)
  
  ##-- Grammaticas cues
  FirstPersonSingularPronounsCount <- get_first_person_singular_pronouns_count(words_tokens)
  FirstPersonPluralPronounsCount <- get_first_person_plural_pronouns_count(words_tokens)
  FirstPersonPronounsCount <- FirstPersonSingularPronounsCount + FirstPersonPluralPronounsCount
  
  SecondPersonSingularPronounsCount <- get_Second_person_singular_pronouns_count(words_tokens)
  SecondersonPluralPronounsCount <- get_second_person_plural_pronouns_count(words_tokens)
  SecondersonPronounsCount <- get_second_person_pronouns_count(words_tokens)
  
  ThirdPersonSingularPronounsCount <- get_first_person_singular_pronouns_count(words_tokens)
  ThirdPersonPluralPronounsCount <- get_first_person_plural_pronouns_count(words_tokens)
  SecondersonPronounsCount <- ThirdPersonSingularPronounsCount + ThirdPersonPluralPronounsCount
  
  PossessivePronounsCount <- get_possessive_pronouns_count(words_tokens)
  
  PunctuationsCount <- get_total_punctuations_count(words_tokens)
  
  # number of unique works (get the histogram of observations and count of number of instance with freq == 1)
  
  return(
    c(
      StatementsCount = StatementsCount,
      LocationsCount = LocationsCount,
      OrganizationsCount = OrganizationsCount,
      PercentagesCount = PercentagesCount,
      PersonsCount = PersonsCount,
      
      CharacterCount = CharactersCount,
      WordsCount = WordsCount,
      DigitsCount = DigitsCount,
      
      FirstPersonSingularPronounsCount = FirstPersonSingularPronounsCount,
      FirstPersonPluralPronounsCount = FirstPersonPluralPronounsCount,
      FirstPersonPronounsCount = FirstPersonPronounsCount,
      
      SecondPersonSingularPronounsCount = SecondPersonSingularPronounsCount,
      SecondersonPluralPronounsCount = SecondersonPluralPronounsCount,
      SecondersonPronounsCount = SecondersonPronounsCount,
      
      ThirdPersonSingularPronounsCount = ThirdPersonSingularPronounsCount,
      ThirdPersonPluralPronounsCount = ThirdPersonPluralPronounsCount,
      SecondersonPronounsCount = SecondersonPronounsCount,
      
      PossessivePronounsCount = PossessivePronounsCount,
      
      PunctuationsCount = PunctuationsCount,
      
      getPOS(raw_text_observation)
    )
  )
}
