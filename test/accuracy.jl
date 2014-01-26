using Base.Test
using MachineLearning
using RDatasets

options = [random_forest_options(),
           decision_tree_options(),
           neural_net_options()]

datasets = [("datasets", "iris", "Species", 0.8)]

for (pkg, dataset, colname, acc_threshold) = datasets
    println("- Dataset ", dataset)
    train, test = split_train_test(data(pkg, dataset))
    ytest = [x for x=test[colname]]
    for opts = options
        model = fit(train, colname, opts)
        yhat = predict(model, test)
        acc = accuracy(ytest, yhat)
        println(@sprintf("Accuracy: %0.3f",acc), "\t", opts)
        @test acc>acc_threshold
    end
end