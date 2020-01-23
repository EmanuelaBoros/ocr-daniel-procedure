import ast
import os
import sys
import matplotlib.pylab as plt
import numpy as np
from scipy.interpolate import make_interp_spline, BSpline
from sklearn.metrics import auc


def get_roc_files(dataset_path, folder_family, lang):
    roc_files = []
    clean_roc_file = "/Users/macintosh/Documents/git/nnkhoa/daniel_v3/dataset/ocr_clean/" + lang + "_roc"
    roc_files.append(clean_roc_file)

    list_dir = list(filter(lambda x: os.path.isdir(
        os.path.join(dataset_path, x)), os.listdir(dataset_path)))
    list_dir.sort()

    for dirname in list_dir:
        if folder_family in dirname:
            roc_files.append(dataset_path + "/" +
                             dirname + "/" + lang + "_roc")

    return roc_files


def extract_stats(dict_string):
    data_point = []
    # print(dict_string)
    for i in dict_string:
        if not i.strip():
            continue
        data = ast.literal_eval(i)
        data_point.append((1 - data["Precision"], data["Recall"]))
    data_point.append((0, 0))
    data_point.append((1, 1))

    data_point = list(set(data_point))
    data_point.sort(key=lambda tup: tup[0])

    return data_point


def get_data_points(roc_files):
    daniel_results = [[]] * len(roc_files)

    # read results into list
    for roc_file in roc_files:
        f = open(roc_file, "r")
        dict_string = f.readlines()
        index = roc_files.index(roc_file)
        daniel_results[index] = []

        daniel_results[index] = extract_stats(dict_string)
        # print(daniel_results[index])
        f.close()

    # print(daniel_results)
    return daniel_results


def plot(daniel_results):
    for i in range(len(daniel_results)):
        # print(daniel_results[i])

        res = [[fpr for fpr, tpr in daniel_results[i]],
               [tpr for fpr, tpr in daniel_results[i]]]

        x = np.array(res[0])
        y = np.array(res[1])

        x_new = np.linspace(x.min(), x.max(), 100)
        spl = make_interp_spline(x, y, k=1)
        y_smooth = spl(x_new)

        roc_auc = auc(x_new, y_smooth)
        #roc_auc = auc(x, y)

        plt.plot(x_new, y_smooth,
                 label='Level: {0}, AUC = {1:0.2f}'.format(i, roc_auc))
        #plt.plot(x, y, label = 'Level: {0}, AUC = {1:0.2f}'.format(i, roc_auc))

    plt.plot([0, 1], [0, 1], 'k--')
    plt.xlim([0.0, 1.01])
    plt.ylim([0.0, 1.01])
    plt.xlabel('False Positive Rate')
    plt.ylabel('True Positive Rate')
    plt.legend(loc='lower right')
    plt.show()


def main():
    dataset_path = sys.argv[1]
    folder_family = sys.argv[2]
    lang = sys.argv[3]

    roc_files = get_roc_files(dataset_path, folder_family, lang)
    plot(get_data_points(roc_files))


if __name__ == '__main__':
    main()
