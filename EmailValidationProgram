email = input("Enter your email ID: ")

variable_2 = 0
variable_3 = 0
variable_4 = 0

if len(email) >= 6:
    if email[0].isalpha():
        if("@" in email) and (email.count("@") == 1):
            if(email[-4] == ".") ^ (email[-3] == "."): #xor operator either only of them will true
                for variable_1 in email:
                    if variable_1 == variable_1.isspace():
                        variable_2 = 1
                    elif variable_1.isalpha():
                        if variable_1 == variable_1.upper():
                            variable_3 = 1
                    elif variable_1.isdigit():
                        continue
                    elif variable_1 == "_" or variable_1 == "." or variable_1 == "@":
                        print("Done!!!")
                        continue

                    else:
                        variable_4 = 1

                    if variable_2 == 1 or variable_3 == 1 or variable_4 == 1:

                        print("Please enter correct email id with no space, #Error5")
            else:
                print("Please enter a valid registered email id with right domain, #Error4")
        else:
            print("Please enter a valid registered email id using special character, #Error3")
    else:
        print("Please enter a valid registered email id with alpha-numeric number, #Error2")
else:
    print("Please enter a valid registered email id, #Error1")
