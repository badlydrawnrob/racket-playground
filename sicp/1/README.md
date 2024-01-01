## Helpful explanations

### 1.1.6

> **Applicative-order or Normal-order evaluation**
>
> **ELi5:** Requires an easier explanaition with examples.
> You can replace the above terms with _left-to-right_ evaluation or _inner-to-outer_ evaluation.
>
> — With Applicative-order, all the argument forms are evaluated **before** the function is invoked
> 
> Functions are evaluated and replaced with the function body and it's values, the values are then evaluated and returned. Inner functions seem to be evaluated first; then outer functions. **Take care with recursive functions**, as they can lead to infinite loops if a function is continually evaluated.

- A [simple explanation](https://sicp-solutions.net/post/sicp-solution-exercise-1-6/) of exercise 1.6
- ⚠️ An example of an infinite loop due to [Applicative-order](https://sicp-solutions.net/post/sicp-solution-exercise-1-5/)
- [Applicative-order -vs- Normal-order](http://tinyurl.com/muck9mby) evaluation examples
- [Order evaluation explained](https://sookocheff.com/post/fp/evaluating-lambda-expressions/#comparison)
    - Also explains Lazy Evaluation (which is used in Haskell and other functional languages)
- [Evaluation strategies](https://en.wikipedia.org/wiki/Evaluation_strategy) in programming languages (long read)


### 1.1.7

> - An explanation of **wishful thinking [here](https://wiki.c2.com/?WishfulThinking) and example [here](https://swiftindepth.com/articles/lets-make-a-music-teacher-2/)**
> - A similar, yet different approach is [HTDP function recipe](https://htdp.org/2019-02-24/part_one.html#%28part._sec~3adesign-func%29) with an example [here](https://ics.uci.edu/~kay/courses/31/design-recipe.html) and [here](https://www.cs.toronto.edu/~david/course-notes/csc110-111/02-functions/07-the-function-design-recipe.html)

The [square root of 2](https://en.wikipedia.org/wiki/Square_root_of_2)


### 1.2.1

- Exercise 3.9: [the environment model](https://www.lvguowei.me/post/sicp-goodness-environment-model/)