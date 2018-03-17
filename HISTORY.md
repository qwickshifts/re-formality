# 0.6.0

## Chore
* `bs-platform@^2.2.2` is added to `peerDependencies`.

# 0.5.0

## Improvements
* **[ BREAKING ]** `value` is user-defined type (was `string`).

In form config:

```diff
+ type value = string;
+ let valueEmpty = value => value === "";
/* or */
+ let valueEmpty = Formality.emptyString;
```

* **[ BREAKING ]** `Formality.Dom.valueOnChange` replaced with `Formality.Dom.toValueOnChange` and `Formality.Dom.valueOnBlur` replaced with `Formality.Dom.toValueOnBlur` to make DOM helpers more composable with non-string `value`. Also, subjectively, handlers are more transparent this way.

```diff
- onChange=(
-   LoginForm.Email
-   |> form.change
-   |> Formality.Dom.valueOnChange
- )

+ onChange=(
+   event =>
+     event
+     |> Formality.Dom.toValueOnChange
+     |> form.change(LoginForm.Email)
+ )
```

## Fixes
* Fix regressions related to empty values validation on form submission

## Chore
* `bs-platform` updated to `2.2.2`.

# 0.4.1

## Improvements
* In case of optional field (e.g. `"" => Valid`) if value is empty string container will always emit `None` (instead of `Some(Valid)`).

# 0.4.0

## Improvements
* **[ BREAKING ]** `validationResult` type is set back to variant. `meta` is removed.

```diff
- type validationResult('message) = {
-   valid: bool,
-   message: option('message),
-   meta: option(string)
- };

+ type validationResult('message) =
+ | Valid
+ | Invalid('message);
```

Validate function looks like this:

```reason
validate: (value, _state) =>
  switch value {
  | "" => Invalid("Uh oh error"),
  | _ => Valid
  }
```

* **[ BREAKING ]** `exception ImpossibleResult` is removed as with the change above we don't get into impossible state anymore! 🎉🎉🎉

# 0.3.1

## Improvements
* Validation `result` type is renamed to `validationResult` to avoid possible conflicts with Pervasive's `result`.

# 0.3.0

## Improvements
* **[ BREAKING ]** Validation `result` type is simplified. Now it's just record.

```diff
- type result('message) =
- | Valid(bool)
- | ValidityBag(validityBag('message));

+ type result('message) = {
+   valid: bool,
+   message: option('message),
+   meta: option(string)
+ };
```

Validate function looks like this:

```reason
validate: (value, _state) =>
  switch value {
  | "" => {
      valid: false,
      message: Some("Uh oh error"),
      meta: None
    }
  | _ => {
      valid: true,
      message: Some("Nice!"),
      meta: None
    }
  }
```

Thanks **[@thangngoc89](https://github.com/thangngoc89)** for suggestion!

# 0.2.0

## Improvements
* **[ BREAKING ]** Global form `strategy` type is removed. Now strategy is defined via field validator. It means `strategy` field is not `option` anymore.

```diff
- let strategy = Formality.Strategy.OnFirstSuccessOrFirstBlur;
```

```diff
- strategy: Some(Strategy.OnFirstSuccessOrFirstBlur)
+ strategy: Strategy.OnFirstSuccessOrFirstBlur

- strategy: None
+ strategy: Strategy.OnFirstSuccessOrFirstBlur
```

* **[ BREAKING ]** Signatures of `form.change` & `form.blur` handlers are changed. Now both accept `value` instead of events. You can use exposed helpers to get value from event.

```diff
- onChange=(Form.Field |> form.change)
- onBlur=(Form.Field |> form.blur)

+ onChange=(Form.Field |> form.change |> Formality.Dom.valueOnChange)
+ onBlur=(Form.Field |> form.blur |> Formality.Dom.valueOnBlur)
```

* **[ BREAKING ]** Signature of `form.submit` handler is changed. Now it accepts `unit` instead of event. You can use exposed helper to prevent default.

```diff
- <form onSubmit=form.submit>
+ <form onSubmit=(form.submit |> Formality.Dom.preventDefault)>
```

* **[ BREAKING ]** Formality doesn't trigger `event.preventDefault` on form submission anymore. Handle it via exposed helper `Formality.Dom.preventDefault` or however you like.

Thanks **[@grsabreu](https://github.com/grsabreu)** & **[@wokalski](https://github.com/wokalski)** for suggestions!

# 0.1.0
Initial release.