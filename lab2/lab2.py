#!/usr/bin/env python
from sklearn.datasets import load_boston
from sklearn.linear_model import LinearRegression
from sklearn.model_selection import train_test_split
from sklearn.preprocessing import PolynomialFeatures
from sklearn.svm import SVR
from sklearn.preprocessing import StandardScaler
from sklearn.tree import DecisionTreeRegressor
from sklearn.ensemble import RandomForestRegressor

import common.feature_selection as feat_sel
import common.test_env as test_env
import numpy as np


def print_metrics(y_true, y_pred, label):
    from sklearn.metrics import r2_score
    # Feel free to extend it with additional metrics from sklearn.metrics
    print('%s R squared: %.2f' % (label, r2_score(y_true, y_pred)))


def linear_regression(X, y, print_text='Linear regression all in'):
    # Split train test sets
    X_train, X_test, y_train, y_test = train_test_split(
        X, y, test_size=0.25, random_state=0)

    # Linear regression all in
    reg = LinearRegression()
    reg.fit(X_train, y_train)
    print_metrics(y_test, reg.predict(X_test), print_text)
    return reg


def linear_regression_selection(X, y):
    X_sel = feat_sel.backward_elimination(X, y)
    return linear_regression(X_sel, y, print_text='Linear regression with feature selection')

# Polynomial Regression


def polynomial_reg(X, y, print_text='Polynomial regression all in'):

    # Polynomial regression all in
    preg = PolynomialFeatures(degree=2)
    X_preg = preg.fit_transform(X)
    return linear_regression(X_preg, y, print_text)


def SVReg(X, y, print_text='SV regression all in'):
    sc = StandardScaler()
    X = sc.fit_transform(X)
    y = sc.fit_transform(np.expand_dims(y, axis=1))
    X_train, X_test, y_train, y_test = train_test_split(
        X, y, test_size=0.25, random_state=0)

    regressor = SVR(kernel='rbf')
    regressor.fit(X_train, y_train)
    print_metrics(np.squeeze(y_test), np.squeeze(
        regressor.predict(X_test)), print_text)
    return regressor


def decission_tree_reg(X, y, print_text='Decission tree regression all in'):
    regressor = DecisionTreeRegressor()
    # SplitTrain test sets
    X_train, X_test, y_train, y_test = train_test_split(
        X, y, test_size=0.25, random_state=0)

    # DTR regression all in
    regressor.fit(X_train, y_train)
    print_metrics(y_test, regressor.predict(X_test), print_text)
    return regressor


def random_forest_reg(X, y, print_text='Random forest regression all in'):
    regressor = RandomForestRegressor(n_estimators=10)
    X_train, X_test, y_train, y_test = train_test_split(
        X, y, test_size=0.25, random_state=0)

    regressor.fit(X_train, y_train)
    print_metrics(y_test, regressor.predict(X_test), print_text)
    return regressor


if __name__ == '__main__':
    REQUIRED = ['numpy', 'statsmodels', 'sklearn']
    test_env.versions(REQUIRED)

    # https://scikit-learn.org/stable/datasets/index.html#boston-house-prices-dataset
    X, y = load_boston(return_X_y=True)

    linear_regression(X, y)
    linear_regression_selection(X, y)
    polynomial_reg(X, y)
    SVReg(X, y)
    decission_tree_reg(X, y)
    random_forest_reg(X, y)
    print('Done')
