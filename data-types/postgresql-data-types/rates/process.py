import csv

# transform 'June 01, 2018' -> '2018-06-01'
def format_date(date):
  a, year = date.split(", ")
  month, day = a.split(" ")
  month_number = {
    "June": "06",
  }[month]

  return f"{year}-{month_number}-{day}"

def format_rate(rate):
  if rate == "NA":
    return "NA"

  return float(rate.replace(",", ""))

with open("2018-06-raw.txt") as f:
  lines = [line for line in f.read().split("\n") if "\t" in line]
  results = []

  for i in range(0, 52):
   part1 = lines[i].strip().split("\t")
   part2 = lines[i+52].strip().split("\t")
   results.append(part1 + part2[1:])

  dates = results[0]
  rates = results[1:]

  with open("processed.csv", "w", newline="") as w:
    writer = csv.writer(w)

    for rate in rates:
      name = rate[0].title()
      for i in range(1, len(dates)):
        # remove `NA` in the middle
        if rate[i] != "NA" or dates[i] == "June 01, 2018":
          writer.writerow([
            name,
            format_date(dates[i]),
            format_rate(rate[i]),
          ])
