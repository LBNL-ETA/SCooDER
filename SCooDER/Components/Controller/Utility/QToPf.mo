within SCooDER.Components.Controller.Utility;
model QToPf
  "Convert reactive power to power factor for inverter control purposes"

  Modelica.Blocks.Interfaces.RealInput q( start=0, unit="var")
    "reactive power [VAr]"
    annotation (Placement(transformation(extent={{-140,-20},{-100,20}})));
  Modelica.Blocks.Interfaces.RealOutput pf( start=1, unit="1") "pf control signal"
    annotation (Placement(transformation(extent={{100,-10},{120,10}})));
  Modelica.Blocks.Interfaces.RealInput p(start=0, unit="W") "active power [W]"
    annotation (Placement(transformation(
        extent={{-20,-20},{20,20}},
        rotation=-90,
        origin={0,120})));
  Real pf_internal( start=1);
  Real pf_calc;
  Real divisor;
equation
    divisor = (p^2 + q^2);
    pf_internal = homotopy(actual = smooth(0, if (divisor > 0) then sqrt(p^2/divisor) else 1), simplified=1);
    //pf_internal = sqrt(p^2/(p^2 + q^2 + 1e-8));
    pf_calc = homotopy(actual = smooth(0, if (q <= 0) then pf_internal else -pf_internal), simplified=pf_internal);
    //pf = if (p > 5 or p < -5) then pf_calc else 1;
    pf = pf_calc;
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end QToPf;
