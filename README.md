# README

This is a Rails 5.2.3 app for mathematical differentiation of polynomials with no other service dependencies.

Usage:

```
GET /differentiate/4/3/0/1
```

gives 200 and

```json
{"expression":"12x^2+6x"}
```

```
GET /differentiate/a/b/c/d
```

gives a 422 and

```json
[{"code":null,"message":"one or more coefficients are not integers"}]
```

