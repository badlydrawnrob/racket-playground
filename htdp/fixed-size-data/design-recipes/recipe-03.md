# Recipe 03

The Design Recipe With a new way of formulating data definitions comes an inspection of the design recipe. This chapter introduces a way to combine two or more means of describing data, and the revised design recipe reflects this, especially the first step:




## 01: When do you need this new way of defining data?

You already know that the need for itemizations is due to distinctions among different classes of information in the problem statement. Similarly, the need for structure-based data definitions is due to the demand to group several different pieces of information.

An itemization of different forms of data—including collections of structures—is required when your problem statement distinguishes different kinds of information and when at least some of these pieces of information consist of several different pieces.

One thing to keep in mind is that data definitions may refer to other data definitions. Hence, if a particular clause in a data definition looks overly complex, it is acceptable to write down a separate data definition for this clause and refer to this auxiliary definition.

And, as always, formulate data examples using the data definitions.




## 02: The second step remains the same.

**Formulate a function signature** that mentions only the names of defined or built-in data collections, add a purpose statement, and create a function header.




## 03: Nothing changes for the third step.

You still need to **formulate functional examples** that illustrate the purpose statement from the second step, and you still need one example per item in the itemization.




## 04: New types of data for template design

The development of the template now exploits two different dimensions: the **itemization** itself and the **use of structures** in its clauses.

By the first, the body of the template consists of a cond expression that has as many cond clauses as the itemizations has items. Furthermore, you must add a condition to each cond clause that identifies the sub-class of data in the corresponding item.

By the second, if an item deals with a structure, the template contains the selector expressions—in the cond clause that deals with the sub-class of data described in the item.

When you choose to describe the data with a separate data definition, however, you do not add selector expressions. Instead, you create a template for the separate data definition to the task at hand and refer to that template with a function call. The latter indicates that this sub-class of data is being processed separately.

**Before going through the work of developing a template**, briefly reflect on the nature of the function. If the problem statement suggests that there are several tasks to be performed, it is likely that a composition of several, separately designed functions is needed instead of a template. In that case, skip the template step.




## 05: Fill the gaps in the template

The more complex you make your data definitions, the more complex this step becomes. The good news is that this design recipe can help in many situations.

If you are stuck, fill the easy cases first and use default values for the others. While this makes some of the test cases fail, you are making progress and you can visualize this progress.

If you are stuck on some cases of the itemization, analyze the examples that correspond to those cases. Determine what the pieces of the template compute from the given inputs. Then consider how to combine these pieces (plus some constants) to compute the desired output. Keep in mind that you might need an auxiliary function.

Also, if your template “calls” another template because the data definitions refer to each other, assume that the other function delivers what its purpose statement and its examples promise—even if this other function’s definition isn’t finished yet.




## 06: Test!

If tests fail, determine what’s wrong: the function, the tests, or both. Go back to the appropriate step.