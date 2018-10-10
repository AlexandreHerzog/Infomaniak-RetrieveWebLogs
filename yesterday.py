#!/usr/bin/env python

from datetime import date, timedelta

yesterday = date.today() - timedelta(1)
print yesterday.strftime('%Y-%m-%d')