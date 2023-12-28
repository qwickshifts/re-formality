module Dom: {
  let preventDefault: (unit => 'a, React.Event.Form.t) => 'a;

  [@deprecated "Use event->React.Event.Form.target##value instead."]
  let toValueOnChange: React.Event.Form.t => 'a;

  [@deprecated "Use event->React.Event.Focus.target##value instead."]
  let toValueOnBlur: React.Event.Focus.t => 'a;

  [@deprecated "Use event->React.Event.Form.target##checked instead."]
  let toCheckedOnChange: React.Event.Form.t => 'a;

  [@deprecated "Use event->React.Event.Focus.target##checked instead."]
  let toCheckedOnBlur: React.Event.Focus.t => 'a;
};
