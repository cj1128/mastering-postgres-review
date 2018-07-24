import psycopg2

# download `AllSets.json` from https://mtgjson.com/
if __name__ == "__main__":
  conn = psycopg2.connect("")
  cur = conn.cursor()

  content = open("AllSets.json").read()
  cur.execute("insert into magic.allsets(data) values('%s')" % content.replace("'", "''"))
  conn.commit()
  conn.close()
