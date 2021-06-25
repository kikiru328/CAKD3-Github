
def Calculate(*args):
    q = input("add/sub/mul/div ? = ")
    if m == "add":
        result = 0
        for i in args:
            result = result + i
            print("Add = ",result)
    elif m == "sub":
        result = 0
        for i in args:
            result = result - i
            print("Subtract = ",result)
    elif m == "div":
        result = 1
        for i in args:
            result = result / i
            print("Divide = ",result)
    elif m == "mul":
        result = 1
        for i in args:
            result = result * i
            print("Multiply = ",result)
    return result
    
    if __name__ == "__main__":
        print(Calculate(1,2,3))
