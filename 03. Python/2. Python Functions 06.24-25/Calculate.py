
def Calculate(*args):
    method = input("add/sub/mul/div ? = ")
    
    if method == "add":
        result_add = 0
        for i in args:
            result_add = result_add + i
            return result_add
        
    elif method == "sub":
        result = 0
        for i in args:
            if result == 0:
                result_sub = i
                result ==1
            else:
                result_sub = result_sub - i
                return print("Subtract = ",result_sub)
    elif method == "div":
        result = 0
        for i in args:
            if result == 0:
                result_div = i
                result == 1
            else:
                if i == 0:
                    return print("Cannot divide 0", Calculate(*args))
                    result_div = result_div / i
        return print("Divide = ",result_div)
    elif method == "mul":
        result = 0
        for i in args:
            if result == 0:
                result_mul = i
                result ==1
            else:
                if i == 0 :
                    a =input("You just multiply 0, Continue to input, yes : ")
                    return a
                    if a == "yes":
                        pass
                result_mul = result_mul * i
        return print("Multiply = ",result)
    
