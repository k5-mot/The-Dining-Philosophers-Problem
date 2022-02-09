import sys


def is_int(s):
  try:
      int(s)
  except:
      return False
  return True


def main(argv=sys.argv):
  print("ARGC: " + str(len(argv)))
  print("ARGV: ", end="")
  # First loop
  itr = iter(argv)
  last = next(itr)
  # 2 ~ (n - 1) loop
  for arg in itr:
    print(last, end=", ")
    last = arg
  # Last loop
  print(last)
  if is_int(last):
    if int(last) == 1:
      return 1
  return 0


if __name__ == "__main__":
    sys.exit(main())
