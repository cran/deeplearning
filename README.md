<!-- README.md is generated from README.Rmd. Please edit that file -->
deeplearning
============

#### Create and train deep neural network of ReLU type with SGD and batch normalization

### About

The deeplearning package is an R package that implements deep neural networks in R. It employes Rectifier Linear Unit functions as its building blocks and trains a neural network with stochastic gradient descent method with batch normalization to speed up the training and promote regularization. Neural networks of such kind of architecture and training methods are state of the art and even achieved suplassing human-level performance in ImageNet competition. The deeplearning package is inspired by another R package darch which implements layerwise Restricted Boltzmann Machine pretraining and dropout and uses its class DArch as the default class.

### Installtion

Install deeplearning from CRAN

    install.packages("deeplearning")

Or install it from github

    devtools::install_github("rz1988/deeplearning")

### Use deeplearning

Using the deeplearning package is designed to be easy and fun. It only takes two steps to run your first neural network.

In step one, the user will create a new neural network. You will need to specify the strucutre of the neural network which are the number of layers and neurons in the network and the type of activation functions. The default activation is rectifier linear unit function for the hidden layers but you can also use other types of activation such as sigmoidal function or write your own activation function.

In step two, the user will train the neural network with a training input and a traing target. There are a number of other training parameters. For how to choose these training parameters please refer to <https://github.com/rz1988/deeplearning>.

### Examples

#### Train a neural networ for regression

    input <- matrix(runif(1000), 500, 2)
    input_valid <- matrix(runif(100), 50, 2)
    target <- rowSums(input + input^2)
    target_valid <- rowSums(input_valid + input_valid^2)


    # create a new deep neural network for classificaiton
    dnn_regression <- new_dnn(
                              c(2, 50, 50, 20, 1),  # The layer structure of the deep neural network.
                                                    # The first element is the number of input variables.
                                                    # The last element is the number of output variables.
                              hidden_layer_default = rectified_linear_unit_function, 
                              # for hidden layers, use rectified_linear_unit_function
                              output_layer_default = linearUnitDerivative # for regression, use linearUnitDerivative function
                              )

    dnn_regression <- train_dnn(
                         dnn_regression,

                         # training data
                         input, # input variable for training
                         target, # target variable for training
                         input_valid, # input variable for validation
                         target_valid, # target variable for validation

                         # training parameters
                         learn_rate_weight = exp(-8) * 10, # learning rate for weights, higher if use dropout
                         learn_rate_bias = exp(-8) * 10, # learning rate for biases, hihger if use dropout
                         learn_rate_gamma = exp(-8) * 10, # learning rate for the gamma factor used
                         batch_size = 10, # number of observations in a batch during training. Higher for faster training. Lower for faster convergence
                         batch_normalization = T, # logical value, T to use batch normalization
                         dropout_input = 0.2, # dropout ratio in input.
                         dropout_hidden = 0.5, # dropout ratio in hidden layers
                         momentum_initial = 0.6, # initial momentum in Stochastic Gradient Descent training
                         momentum_final = 0.9, # final momentum in Stochastic Gradient Descent training
                         momentum_switch = 100, # after which the momentum is switched from initial to final momentum
                         num_epochs = 300, # number of iterations in training

                         # Error function
                         error_function = meanSquareErr, # error function to minimize during training. For regression, use meanSquareErr
                         report_classification_error = F # whether to print classification error during training
    )

    # the prediciton by dnn_regression
    pred <- predict(dnn_regression)

    # calculate the r-squared of the prediciton
    rsq(dnn_regression)

    # calcualte the r-squared of the prediciton in validation
    rsq(dnn_regression, input = input_valid, target = target_valid)

#### Train a neural network for classification


    input <- matrix(runif(1000), 500, 2)
    input_valid <- matrix(runif(100), 50, 2)
    target <- (cos(rowSums(input + input^2)) > 0.5) * 1
    target_valid <- (cos(rowSums(input_valid + input_valid^2)) > 0.5) * 1

    # create a new deep neural network for classificaiton
    dnn_classification <- new_dnn(
      c(2, 50, 50, 20, 1),  # The layer structure of the deep neural network.
                            # The first element is the number of input variables.
                            # The last element is the number of output variables.
      hidden_layer_default = rectified_linear_unit_function, # for hidden layers, use rectified_linear_unit_function
      output_layer_default = sigmoidUnitDerivative # for classification, use sigmoidUnitDerivative function
    )

    dnn_classification <- train_dnn(
      dnn_classification,

      # training data
      input, # input variable for training
      target, # target variable for training
      input_valid, # input variable for validation
      target_valid, # target variable for validation

      # training parameters
      learn_rate_weight = exp(-8) * 10, # learning rate for weights, higher if use dropout
      learn_rate_bias = exp(-8) * 10, # learning rate for biases, hihger if use dropout
      learn_rate_gamma = exp(-8) * 10, # learning rate for the gamma factor used
      batch_size = 10, # number of observations in a batch during training. Higher for faster training. Lower for faster convergence
      batch_normalization = T, # logical value, T to use batch normalization
      dropout_input = 0.2, # dropout ratio in input.
      dropout_hidden = 0.5, # dropout ratio in hidden layers
      momentum_initial = 0.6, # initial momentum in Stochastic Gradient Descent training
      momentum_final = 0.9, # final momentum in Stochastic Gradient Descent training
      momentum_switch = 100, # after which the momentum is switched from initial to final momentum
      num_epochs = 100, # number of iterations in training

      # Error function
      error_function = crossEntropyErr, # error function to minimize during training. For regression, use crossEntropyErr
      report_classification_error = T # whether to print classification error during training
    )

    # the prediciton by dnn_regression
    pred <- predict(dnn_classification)

    hist(pred)

    # calculate the r-squared of the prediciton
    AR(dnn_classification)

    # calcualte the r-squared of the prediciton in validation
    AR(dnn_classification, input = input_valid, target = target_valid)

    # print the layer weights
    # this function can print heatmap, histogram, or a surface
    print_weight(dnn_regression, 1, type = "heatmap")

    print_weight(dnn_regression, 2, type = "surface")

    print_weight(dnn_regression, 3, type = "histogram")

#### References

Nitish Srivastava, Geoffrey Hinton, Alex Krizhevsky, Ilya Sutskever, Ruslan Salakhutdinov, 2013, Dropout: A Simple Way to Prevent Neural Networks from Overfitting, Journal of Machine Learning Research 15 (2014) 1929-1958

Sergey Ioffe, Christian Szegedy, 2015, Batch Normalization: Accelerating Deep Network Training by Reducing Internal Covariate Shift, Proceedings of the 32 nd International Conference on Machine Learning, Lille, France, 2015.

Kaiming He, Xiangyu Zhang, Shaoqing Ren, Jian Sun, 2015, Delving Deep into Rectifiers: Surpassing Human-Level Performance on ImageNet Classification, arXiv

X. Glorot, A. Bordes, and Y. Bengio, 2011,Deep sparse rectifier networks. In Proceedings of the 14th International Conference on Artificial Intelligence and Statistics, pages 315–323

Drees, Martin (2013). "Implementierung und Analyse von tiefen Architekturen in R". German. Master's thesis. Fachhochschule Dortmund.

Rueckert, Johannes (2015). "Extending the Darch library for deep architectures". Project thesis. Fachhochschule Dortmund. URL: [saviola.de](http://static.saviola.de/publications/rueckert_2015.pdf)
