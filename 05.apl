)copy 5 file_io
f ← FIO∆read_file 'inputs/05.txt'
seats ← f ⊂⍨ f ∈ 'FBLR'
binaries ← (⊃ seats) ∈ 'BR'
decimals ← 2 ⊥ ⍉ binaries
max ← ⌈/ decimals
min ← ⌊/ decimals
expected ← (max + min) × (1 + max - min) ÷ 2

⎕ ←max ⍝ (answer to part 1)
⎕ ← expected - +/ decimals ⍝ (answer to part 2)
