
def cal_4(*args):
    method = input("Method:add/sub/mul/div")
    if method == 'add':
        for i in args:
            added_result = 0
            added_result += i
            return added_result