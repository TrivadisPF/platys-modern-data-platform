import argparse


def main():
    print("running main parser")
    parser = argparse.ArgumentParser(description='Modern data analytics stack configuration generator')
    parser.add_argument('--env-file', required=1,
                        help='The location of the env-file which is required by the generator engine to enable/disable services'
                        )

    args = parser.parse_args()
    print(args)


if __name__ == "__main__":
    main()
