#!/usr/bin/env python

import argparse
from datetime import datetime


if __name__ == "__main__":
    parser = argparse.ArgumentParser(description="Convert YYYYdDOY to YYYYMMDD")
    parser.add_argument("date", help="date in the format YYYYdDOY")
    args = parser.parse_args()

    doy_date_string = args.date
    dt = datetime.strptime(doy_date_string, "%Yd%j")
    print(dt.strftime("%Y%m%d"))
