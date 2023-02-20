# Used by "mix format"
[
  inputs: ["{mix,.formatter}.exs", "{config,lib,test}/**/*.{ex,exs}"],
  locals_without_parens: [rules: 2, macro_prefix: 1, macro_suffix: 1],
  export: [
    locals_without_parens: [rules: 2]
  ]
]
