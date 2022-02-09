import sys

def main(argv=sys.argv):
    for v in argv:
      print(v, end=", ")
    print()
    return 0

if __name__ == "__main__":
    sys.exit(main())
