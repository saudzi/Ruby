#!/usr/bin/env python
import numpy as np
import pandas as pd
from sklearn.model_selection import train_test_split
from sklearn.linear_model import LogisticRegression
from sklearn.neighbors import KNeighborsClassifier
from sklearn.tree import DecisionTreeClassifier
from sklearn.ensemble import RandomForestClassifier
from sklearn.metrics import confusion_matrix
from sklearn.naive_bayes import MultinomialNB
from sklearn.svm import SVC
from common import describe_data, test_env


def read_data(file):
    """Return pandas dataFrame read from csv file"""
    try:
        return pd.read_excel(file)
    except FileNotFoundError:
        exit('ERROR: ' + file + ' not found')


def preprocess_data(df, verbose=False):
    y_column = 'In university after 4 semesters'

    # Features can be excluded by adding column name to list
    drop_columns = []

    categorical_columns = [
        'Faculty',
        'Paid tuition',
        'Study load',
        'Previous school level',
        'Previous school study language',
        'Recognition',
        'Study language',
        'Foreign student'
    ]

    # Handle dependent variable
    if verbose:
        print('Missing y values: ', df[y_column].isna().sum())

    y = df[y_column].values
    # Encode y. Naive solution
    y = np.where(y == 'No', 0, y)
    y = np.where(y == 'Yes', 1, y)
    y = y.astype(float)

    # Drop also dependent variable variable column to leave only features
    drop_columns.append(y_column)
    df = df.drop(labels=drop_columns, axis=1)

    # Remove drop columns for categorical columns just in case
    categorical_columns = [
        i for i in categorical_columns if i not in drop_columns]

    # STUDENT SHALL ENCODE CATEGORICAL FEATURES
    for i in categorical_columns:
        df[i] = df[i].fillna(value='Missing')
    dum = pd.get_dummies(df, prefix_sep=":", columns=categorical_columns)
    df = dum.drop(columns=['Paid tuition:No', 'Foreign student:No', 'Previous school study language:Not known',
                           'Study load:Partial', 'Faculty:School of Engineering', 'Recognition:Missing', 'Study language:Estonian'])
    df = df.fillna(value=0)

    # Handle missing data. At this point only exam points should be missing
    # It seems to be easier to fill whole data frame as only particular columns
    if verbose:
        describe_data.print_nan_counts(df)

    # STUDENT SHALL HANDLE MISSING VALUES

    if verbose:
        describe_data.print_nan_counts(df)

    # Return features data frame and dependent variable
    return df, y


# STUDENT SHALL CREATE FUNCTIONS FOR LOGISTIC REGRESSION CLASSIFIER, KNN
# CLASSIFIER, SVM CLASSIFIER, NAIVE BAYES CLASSIFIER, DECISION TREE
# CLASSIFIER AND RANDOM FOREST CLASSIFIER

def logistReg(train_X, train_y, test_X, test_y):

    # CLASS
    regClass = LogisticRegression(
        solver='newton-cg', multi_class='multinomial')

    # FIT
    regClass.fit(train_X, train_y)

    # PREDICT Y
    predict_y = regClass.predict(test_X)

    # PRINT
    print("LOGISTIC REGRESSION TEST")
    print("CONFUSION MATRIX")
    print(confusion_matrix(test_y, predict_y))


def KNNn(train_X, train_y, test_X, test_y):

    # CLASS
    KNNclass = KNeighborsClassifier(n_neighbors=5)

    # FIT
    KNNclass.fit(train_X, train_y)

    # PREDICT Y
    predict_y = KNNclass.predict(test_X)

    # PRINT
    print("KNN TEST")
    print("CONFUSION MATRIX")
    print(confusion_matrix(test_y, predict_y))


def svc(train_X, train_y, test_X, test_y):

    # CLASS
    classif = SVC(kernel='sigmoid', random_state=0,
                  gamma=.01, C=1, probability=True)

    # FIT
    classif.fit(train_X, train_y)

    # PREDICT Y
    predict_y = classif.predict(test_X)

    # PRINT
    print("SVC TEST")

    print("CONFUSION MATRIX")
    print(confusion_matrix(test_y, predict_y))


def naiveB(train_X, train_y, test_X, test_y):

    # CLASS
    classif = MultinomialNB()

    # FIT
    classif.fit(train_X, train_y)

    # PREDICT Y
    predict_y = classif.predict(test_X)

    # PRINT
    print("NAIVE BAYES TEST")

    print("CONFUSION MATRIX")
    print(confusion_matrix(test_y, predict_y))


def decisionTreeClass(train_X, train_y, test_X, test_y):
    # CLASS
    classif = DecisionTreeClassifier()

    # FIT
    classif.fit(train_X, train_y)

    # PREDICT Y
    predict_y = classif.predict(test_X)

    # PRINT
    print("DECISION TREE TEST")

    print("CONFUSION MATRIX")
    print(confusion_matrix(test_y, predict_y))


def randomForestClass(train_X, train_y, test_X, test_y):
    # CLASS
    classif = RandomForestClassifier(n_estimators=12)

    # FIT
    classif.fit(train_X, train_y)

    # PREDICT Y
    predict_y = classif.predict(test_X)

    # PRINT
    print("RANDOM FOREST TEST")

    print("CONFUSION MATRIX")
    print(confusion_matrix(test_y, predict_y))


if __name__ == '__main__':
    modules = ['numpy', 'pandas', 'sklearn']
    test_env.versions(modules)

    students = read_data('data/students.xlsx')

    # STUDENT SHALL CALL PRINT_OVERVIEW AND PRINT_CATEGORICAL FUNCTIONS WITH
    # FILE NAME AS ARGUMENT
    describe_data.print_overview(
        students, file='results/students_overview.txt')
    describe_data.print_categorical(
        students, file='results/students_categorical_data.txt')

    # Filter students
    describe_data.print_overview(
        students[students['In university after 4 semesters'] == 'Yes'], file='results/filltered_students_overview.txt')
    describe_data.print_categorical(
        students[students['In university after 4 semesters'] == 'Yes'], file='results/filltered_students_categorical_data.txt')

    students_X, students_y = preprocess_data(students)

    # train_test_split
    train_X, test_X, train_y, test_y = train_test_split(
        students_X, students_y, test_size=0.25, random_state=51)

    # STUDENT SHALL CALL CREATED CLASSIFIERS FUNCTIONS

    logistReg(train_X, train_y, test_X, test_y)
    KNNn(train_X, train_y, test_X, test_y)
    svc(train_X, train_y, test_X, test_y)
    naiveB(train_X, train_y, test_X, test_y)
    decisionTreeClass(train_X, train_y, test_X, test_y)
    randomForestClass(train_X, train_y, test_X, test_y)

    print('Done')
