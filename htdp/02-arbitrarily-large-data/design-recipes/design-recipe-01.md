# Design recipe
## Arbitrarily large data

- [Self-referential data definitions](https://htdp.org/part_two.html#%28counter._%28figure._fig~3adata-def-arrows%29%29)

See about chapter for an overview (it's too long for here)



### Snippet from the recipe

Used in combination with the Q&A from the full design recipe (above)

| **steps** | **outcome** | **activity** |
|-----------|-------------|--------------|
| problem analysis | data definition | Develop a data representation for the information; create examples for specific items of information and interpret data as information; identify self-references. |
| header | signature; purpose; dummy definition | Write down a signature using defined names; formulate a concise purpose statement; create a dummy function that produces a constant value from the specified range.
| examples | examples and tests | Work through several examples, at least one per clause in the data definition.
| template | function template | Translate the data definition into a template: one cond clause per data clause; selectors where the condition identifies a structure; one natural recursion per self-reference.
| definition | full-fledged definition | Find a function that combines the values of the expressions in the cond clauses into the expected answer.
| test | validated tests | Turn them into check-expect tests and run them.