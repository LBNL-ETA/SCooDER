within SCooDER.Reporting;
model Capacitor
  parameter Real C( unit="F");
  input Real V( unit="V");
  output Real I( unit="A");
equation
  I = C * der(V);
end Capacitor;
