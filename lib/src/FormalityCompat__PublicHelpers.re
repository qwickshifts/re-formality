module Dom = {
  let preventDefault = (submit, event) => {
    if (!event->React.Event.Form.defaultPrevented) {
      event->React.Event.Form.preventDefault;
    };
    submit();
  };

  let toValueOnChange = event => event->React.Event.Form.target##value;
  let toValueOnBlur = event => event->React.Event.Focus.target##value;
  let toCheckedOnChange = event => event->React.Event.Form.target##checked;
  let toCheckedOnBlur = event => event->React.Event.Focus.target##checked;
};
