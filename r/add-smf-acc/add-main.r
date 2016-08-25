#-------------------------------------------------------------------------------------------------------------
# File:        add-main.r
# Description: Main application entry point
#-------------------------------------------------------------------------------------------------------------

library(doBy) #install.packages("doBy")

#-------------------------------------------------------------------------------------------------------------
# Imports
#-------------------------------------------------------------------------------------------------------------
source("./add-fext.R")     # Import features extraction R file

#-------------------------------------------------------------------------------------------------------------
# Decision Tree
source("./add-model-tree.r")
best_tree_result <- best_tree()

#-------------------------------------------------------------------------------------------------------------
# SVM
source("./add-model-svm.r")
best_svm_result <- best_svm()

#-------------------------------------------------------------------------------------------------------------
# NNet
source("./add-model-nnet.r")
best_nnet_result <- best_nnet()

#-------------------------------------------------------------------------------------------------------------
# Random Forest
source("./add-model-forest.r")
best_forest_result <- best_forest()

#-------------------------------------------------------------------------------------------------------------
# Random Boost
source("./add-model-boost.r")
best_boost_result <- best_boost()

#-------------------------------------------------------------------------------------------------------------
# Logistic Regression
source("./add-model-linear.r")
best_linear_result <- best_linear()



#-------------------------------------------------------------------------------------------------------------
# Reporting
print(":: The following display each optimized model with control parameters ::")


print("")
print(":: Decision Tree ::")
best_tree_result

print("")
print(":: SVM ::")
best_svm_result

print("")
print(":: Neural Net ::")
best_nnet_result

print("")
print(":: Random Forest ::")
best_forest_result

print("")
print(":: Boost Decision Tree ::")
best_boost_result

print("")
print(":: LOgistic Regression ::")
best_linear_result


final_result <- data.frame(Accuracy = best_tree_result$accuracy)
final_result <- rbind(final_result, c(best_svm_result$accuracy))
final_result <- rbind(final_result, c(best_nnet_result$accuracy))
final_result <- rbind(final_result, c(best_forest_result$accuracy))
final_result <- rbind(final_result, c(best_boost_result$accuracy))
final_result <- rbind(final_result, c(best_linear_result$accuracy))
rownames(final_result) <- c("Decision Tree", "Svm", "Neural Net", "Tree Forest", "Boost Decision Tree", "Linear")

ggplot(final_result, aes(x=final_result, y=factor(rownames(final_result)))) +
  geom_point(shape=19, size = 3) + 
    xlab("Model Accuracy") + ylab("Predictive Models") + 
      ggtitle("Final Predicitve Models Accuracy")
