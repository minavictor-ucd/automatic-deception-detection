#-------------------------------------------------------------------------------------------------------------
# File:        add-fext.r
# Description: Features extration for single observation automated deception detection
#-------------------------------------------------------------------------------------------------------------

#-------------------------------------------------------------------------------------------------------------
# Package required
#-------------------------------------------------------------------------------------------------------------
library("rJava") 

#-------------------------------------------------------------------------------------------------------------
# config(s)
#-------------------------------------------------------------------------------------------------------------
jar_class_path = "../../target/"
feature_extraction_jclass ="ie/ucd/mscba/add/cues/deception/r/RDeceptionFeatureExtractor"

#-------------------------------------------------------------------------------------------------------------
# Pre-run java JAR config
#-------------------------------------------------------------------------------------------------------------
.jinit()
.jaddClassPath(paste(jar_class_path, "lingpipe-4.1.0.jar", sep=""))
.jaddClassPath(paste(jar_class_path, "add-nlp-fext.jar", sep=""))

#-------------------------------------------------------------------------------------------------------------
# Global object(s)
#-------------------------------------------------------------------------------------------------------------
deception_feature_extractor <- .jnew(feature_extraction_jclass)

#-------------------------------------------------------------------------------------------------------------
# Helpers
#-------------------------------------------------------------------------------------------------------------

.getNumbersCountCue <- function(dfe_jobject, text_observation) { .jcall(dfe_jobject, "D", "getNumbersCountCue", text_observation) }
.getSyllablesCountCue <- function(dfe_jobject, text_observation) { .jcall(dfe_jobject, "D", "getSyllablesCountCue", text_observation) }
.getComplexWordsCountCue <- function(dfe_jobject, text_observation) { .jcall(dfe_jobject, "D", "getComplexWordsCountCue", text_observation) }

.getMeasurementsCountCue <- function(dfe_jobject, text_observation) { .jcall(dfe_jobject, "D", "getMeasurementsCountCue", text_observation) }
.getSymbolsCountCue <- function(dfe_jobject, text_observation) { .jcall(dfe_jobject, "D", "getSymbolsCountCue", text_observation) }

.getSMOGReadabilityIndexCue <- function(dfe_jobject, text_observation) { .jcall(dfe_jobject, "D", "getSMOGReadabilityIndexCue", text_observation) }
.getSMOGReadabilityCue <- function(dfe_jobject, text_observation) { .jcall(dfe_jobject, "D", "getSMOGReadabilityCue", text_observation) }
.getGunningFogIndexCue <- function(dfe_jobject, text_observation) { .jcall(dfe_jobject, "D", "getGunningFogIndexCue", text_observation) }
.getFleschReadabilityIndexCue <- function(dfe_jobject, text_observation) { .jcall(dfe_jobject, "D", "getFleschReadabilityIndexCue", text_observation) }
.getFleschKincaidReadabilityIndexCue <- function(dfe_jobject, text_observation) { .jcall(dfe_jobject, "D", "getFleschKincaidReadabilityIndexCue", text_observation) }
.getColemanLiauIndexCue <- function(dfe_jobject, text_observation) {.jcall(dfe_jobject, "D", "getColemanLiauIndexCue", text_observation) }
.getAutomatedReadabilityIndexCue <- function(dfe_jobject, text_observation) { .jcall(dfe_jobject, "D", "getAutomatedReadabilityIndexCue", text_observation) }

.getAdditionTransitionWordsCountCue <- function(dfe_jobject, text_observation) { .jcall(dfe_jobject, "D", "getAdditionTransitionWordsCountCue", text_observation) }
.getIntroductionTransitionWordsCountCue <- function(dfe_jobject, text_observation) { .jcall(dfe_jobject, "D", "getIntroductionTransitionWordsCountCue", text_observation) }
.getReferenceTransitionWordsCountCue <- function(dfe_jobject, text_observation) { .jcall(dfe_jobject, "D", "getReferenceTransitionWordsCountCue", text_observation) }
.getSimilarityTransitionWordsCountCue <- function(dfe_jobject, text_observation) { .jcall(dfe_jobject, "D", "getSimilarityTransitionWordsCountCue", text_observation) }
.getIdentificationTransitionWordsCountCue <- function(dfe_jobject, text_observation) { .jcall(dfe_jobject, "D", "getIdentificationTransitionWordsCountCue", text_observation) }
.getClarificationTransitionWordsCountCue <- function(dfe_jobject, text_observation) { .jcall(dfe_jobject, "D", "getClarificationTransitionWordsCountCue", text_observation) }
.getAdditiveTransitionWordsCountCue <- function(dfe_jobject, text_observation) { .jcall(dfe_jobject, "D", "getAdditiveTransitionWordsCountCue", text_observation) }

.getConflictTransitionWordsCountCue <- function(dfe_jobject, text_observation) { .jcall(dfe_jobject, "D", "getConflictTransitionWordsCountCue", text_observation) }
.getEmphasisTransitionWordsCountCue <- function(dfe_jobject, text_observation) { .jcall(dfe_jobject, "D", "getEmphasisTransitionWordsCountCue", text_observation) }
.getConcessionTransitionWordsCountCue <- function(dfe_jobject, text_observation) { .jcall(dfe_jobject, "D", "getConcessionTransitionWordsCountCue", text_observation) }
.getDismissalTransitionWordsCountCue <- function(dfe_jobject, text_observation) { .jcall(dfe_jobject, "D", "getDismissalTransitionWordsCountCue", text_observation) }
.getReplacementTransitionWordsCountCue <- function(dfe_jobject, text_observation) { .jcall(dfe_jobject, "D", "getReplacementTransitionWordsCountCue", text_observation) }
.getAdversativeTransitionWordsCountCue <- function(dfe_jobject, text_observation) { .jcall(dfe_jobject, "D", "getAdversativeTransitionWordsCountCue", text_observation) }

.getCausalAndReasonTransitionWordsCountCue <- function(dfe_jobject, text_observation) { .jcall(dfe_jobject, "D", "getCausalAndReasonTransitionWordsCountCue", text_observation) }
.getConditionTransitionWordsCountCue <- function(dfe_jobject, text_observation) { .jcall(dfe_jobject, "D", "getConditionTransitionWordsCountCue", text_observation) }
.getEffectAndResultTransitionWordsCountCue <- function(dfe_jobject, text_observation) { .jcall(dfe_jobject, "D", "getEffectAndResultTransitionWordsCountCue", text_observation) }
.getPurposeTransitionWordsCountCue <- function(dfe_jobject, text_observation) { .jcall(dfe_jobject, "D", "getPurposeTransitionWordsCountCue", text_observation) }
.getConsequenceTransitionWordsCountCue <- function(dfe_jobject, text_observation) { .jcall(dfe_jobject, "D", "getConsequenceTransitionWordsCountCue", text_observation) }
.getCausalTransitionWordsCountCue <- function(dfe_jobject, text_observation) { .jcall(dfe_jobject, "D", "getCausalTransitionWordsCountCue", text_observation) }

.getNumericalTransitionWordsCountCue <- function(dfe_jobject, text_observation) { .jcall(dfe_jobject, "D", "getNumericalTransitionWordsCountCue", text_observation) }
.getContinuationTransitionWordsCountCue <- function(dfe_jobject, text_observation) { .jcall(dfe_jobject, "D", "getContinuationTransitionWordsCountCue", text_observation) }
.getConclusionTransitionWordsCountCue <- function(dfe_jobject, text_observation) { .jcall(dfe_jobject, "D", "getConclusionTransitionWordsCountCue", text_observation) }
.getDigressionTransitionWordsCountCue <- function(dfe_jobject, text_observation) { .jcall(dfe_jobject, "D", "getDigressionTransitionWordsCountCue", text_observation) }
.getResumptionTransitionWordsCountCue <- function(dfe_jobject, text_observation) { .jcall(dfe_jobject, "D", "getResumptionTransitionWordsCountCue", text_observation) }
.getSummationTransitionWordsCountCue <- function(dfe_jobject, text_observation) { .jcall(dfe_jobject, "D", "getSummationTransitionWordsCountCue", text_observation) }
.getSequentialTransitionWordsCountCue <- function(dfe_jobject, text_observation) { .jcall(dfe_jobject, "D", "getSequentialTransitionWordsCountCue", text_observation) }

.getWrongWordsCountCue <- function(dfe_jobject, text_observation) { .jcall(dfe_jobject, "D", "getWrongWordsCountCue", text_observation) }

#-------------------------------------------------------------------------------------------------------------
# TEMPLATE
#-------------------------------------------------------------------------------------------------------------

#.get-Cue <- function(dfe_jobject, text_observation) {   
#  rv <- .jcall(dfe_jobject, "D", "", text_observation)
#  names(rv) <- ""
# return (rv)
#}

#-------------------------------------------------------------------------------------------------------------
# API
#-------------------------------------------------------------------------------------------------------------

deception_features_extractor_java_nlp <- function(raw_text_observation) {
  return
  (
    c(
      NumbersCount = .getNumbersCountCue(deception_feature_extractor, raw_text_observation),
      SyllablesCount = .getSyllablesCountCue(deception_feature_extractor, raw_text_observation),
      ComplexWordsCount = .getComplexWordsCountCue(deception_feature_extractor, raw_text_observation),
      
      MeasurementsCount = .getMeasurementsCountCue(deception_feature_extractor, raw_text_observation),
      SymbolsCount = .getSymbolsCountCue(deception_feature_extractor, raw_text_observation),
      
      WrongWordsCount = .getWrongWordsCountCue(deception_feature_extractor, raw_text_observation),
      
      SMOGReadabilityIndex = .getSMOGReadabilityIndexCue(deception_feature_extractor, raw_text_observation),
      SMOGReadability = .getSMOGReadabilityCue(deception_feature_extractor, raw_text_observation),
      GunningFogIndex = .getGunningFogIndexCue(deception_feature_extractor, raw_text_observation),
      FleschReadabilityIndex = .getFleschReadabilityIndexCue(deception_feature_extractor, raw_text_observation),
      FleschKincaidReadabilityIndex = .getFleschKincaidReadabilityIndexCue(deception_feature_extractor, raw_text_observation),
      ColemanLiauIndex = .getColemanLiauIndexCue(deception_feature_extractor, raw_text_observation),
      AutomatedReadabilityIndex = .getAutomatedReadabilityIndexCue(deception_feature_extractor, raw_text_observation),
      
      AdditionTransitionWordsCount = .getAdditionTransitionWordsCountCue(deception_feature_extractor, raw_text_observation),
      IntroductionTransitionWordsCount = .getIntroductionTransitionWordsCountCue(deception_feature_extractor, raw_text_observation),
      ReferenceTransitionWordsCount = .getReferenceTransitionWordsCountCue(deception_feature_extractor, raw_text_observation),
      SimilarityTransitionWordsCount = .getSimilarityTransitionWordsCountCue(deception_feature_extractor, raw_text_observation),
      IdentificationTransitionWordsCount = .getIdentificationTransitionWordsCountCue(deception_feature_extractor, raw_text_observation),
      ClarificationTransitionWordsCount = .getClarificationTransitionWordsCountCue(deception_feature_extractor, raw_text_observation),
      AdditiveTransitionWordsCount = .getAdditiveTransitionWordsCountCue(deception_feature_extractor, raw_text_observation),
      
      ConflictTransitionWordsCount = .getConflictTransitionWordsCountCue(deception_feature_extractor, raw_text_observation),
      EmphasisTransitionWordsCount = .getEmphasisTransitionWordsCountCue(deception_feature_extractor, raw_text_observation),
      ConcessionTransitionWordsCount = .getConcessionTransitionWordsCountCue(deception_feature_extractor, raw_text_observation),
      DismissalTransitionWordsCount = .getDismissalTransitionWordsCountCue(deception_feature_extractor, raw_text_observation),
      ReplacementTransitionWordsCount = .getReplacementTransitionWordsCountCue(deception_feature_extractor, raw_text_observation),
      AdversativeTransitionWordsCount = .getAdversativeTransitionWordsCountCue(deception_feature_extractor, raw_text_observation),
      
      CausalAndReasonTransitionWordsCount = .getCausalAndReasonTransitionWordsCountCue(deception_feature_extractor, raw_text_observation),
      ConditionTransitionWordsCount = .getConditionTransitionWordsCountCue(deception_feature_extractor, raw_text_observation),
      EffectAndResultTransitionWordsCount = .getEffectAndResultTransitionWordsCountCue(deception_feature_extractor, raw_text_observation),
      PurposeTransitionWordsCount = .getPurposeTransitionWordsCountCue(deception_feature_extractor, raw_text_observation),
      ConsequenceTransitionWordsCount = .getConsequenceTransitionWordsCountCue(deception_feature_extractor, raw_text_observation),
      CausalTransitionWordsCount = .getCausalTransitionWordsCountCue(deception_feature_extractor, raw_text_observation),

      NumericalTransitionWordsCount = .getNumericalTransitionWordsCountCue(deception_feature_extractor, raw_text_observation),
      ContinuationTransitionWordsCount = .getContinuationTransitionWordsCountCue(deception_feature_extractor, raw_text_observation),
      ConclusionTransitionWordsCount = .getConclusionTransitionWordsCountCue(deception_feature_extractor, raw_text_observation),
      DigressionTransitionWordsCount = .getDigressionTransitionWordsCountCue(deception_feature_extractor, raw_text_observation),
      ResumptionTransitionWordsCount = .getResumptionTransitionWordsCountCue(deception_feature_extractor, raw_text_observation),
      SummationTransitionWordsCount = .getSummationTransitionWordsCountCue(deception_feature_extractor, raw_text_observation),
      SequentialTransitionWordsCount = .getSequentialTransitionWordsCountCue(deception_feature_extractor, raw_text_observation)
    )
  )
}