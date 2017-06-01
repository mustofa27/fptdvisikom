%training extrack
call_training;

%testing extrack
call_testing;

%ELM
%training untuk membentuk pola neuron, hasil disimpan di elm_model.mat
elm_train('training_features.txt', 1, 20, 'sig');
%testing
elm_predict('testing_features.txt')

