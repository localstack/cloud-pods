# Iris classification using sklearn
import json
import numpy as np
import pandas as pd
from sklearn import model_selection
from sklearn.linear_model import LogisticRegression

import warnings

warnings.filterwarnings("ignore", category=UserWarning)


def train_classifier():
    url = "https://raw.githubusercontent.com/jbrownlee/Datasets/master/iris.csv"
    names = ["sepal-length", "sepal-width", "petal-length", "petal-width", "class"]
    dataset = pd.read_csv(url, names=names)

    # Split-out validation dataset
    array = dataset.values
    X = array[:, 0:4]
    Y = array[:, 4]
    validation_size = 0.20
    X_train, X_validation, Y_train, Y_validation = model_selection.train_test_split(
        X, Y, test_size=validation_size, random_state=7
    )

    # Train
    model = LogisticRegression()
    model.fit(X_train, Y_train)
    return model


def lambda_handler(event, context):
    model = train_classifier()
    input = event["values"]
    input = np.array(input)
    prediction = model.predict(input)
    return {"statusCode": 200, "body": json.dumps(prediction.tolist())}
