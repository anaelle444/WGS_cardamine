#Hard filtering conditions

I did different conditions of hard filtering : 
- settings : filtering criteria specified to remove low-quality variants based on certain metrics such as quality score, depth, and more
- not called : hardfiltering the variants that were not actually called but GATK keep them with a genotype of 0/0 instead of ./.

Correspondance of the conditions : 

| conditions | 1 | 2 | 3 | 4 |
|------------|---|---|---|---|
| settings   |   | X |   | X |
| not called |   |   | X | X |

The hard filtering happens in 2 steps here : the filtering and the selection, both scripts are written in each condition folder.
