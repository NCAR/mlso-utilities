#!/usr/bin/env python

"""Resolve DOIs and check they are resolving correctly.
"""

import argparse
import csv
import sys

import requests


def check_dois(records):
    has_error = False
    for r in records:
        doi = r["doi"].strip()
        standard = r["standard"].strip()
        print(f"checking resolving {doi} -> {standard}")

        try:
            r = requests.get(doi, timeout=10.0, allow_redirects=True)
        except requests.ConnectionError as e:
            print(f"    connection error\n")
            print(f"    {e}\n")
            has_error = True
            continue
        except requests.exceptions.Timeout as e:
            print(f"    timed out")
            has_error = True
            continue

        if len(r.history) > 1:
            result = r.history[-1].url
        else:
            result = r.url

        if standard == result:
            print(f"  resolved: {standard}")
        else:
            print(f"  error: {result}, not {standard}")
            has_error = True

    return(has_error)


def read_csvfile(filename):
    with open(filename) as csvfile:
        csv_reader = csv.reader(csvfile)
        records = [{'doi': line[0], 'standard': line[1]} for line in csv_reader]
    return(records)


def main():
    parser = argparse.ArgumentParser(description="Check DOI resolution")

    filename_help = "filename of CSV containing DOIs and standard URL"
    parser.add_argument("doi_csv_filename", type=str, help=filename_help)

    args = parser.parse_args()

    has_error = check_dois(read_csvfile(args.doi_csv_filename))
    sys.exit(1 if has_error else 0)


if __name__ == "__main__":
    main()
