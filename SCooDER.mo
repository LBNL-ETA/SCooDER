within ;
package SCooDER

  package Solar

    block DiffusePerez
      "Hemispherical diffuse irradiation on a tilted surface using Perez's anisotropic sky model"
      extends
        Buildings.BoundaryConditions.SolarIrradiation.BaseClasses.PartialSolarIrradiation;

      parameter Real rho(min=0, max=1, final unit="1")=0.2 "Ground reflectance";
      parameter Modelica.SIunits.Angle lat "Latitude";
      parameter Modelica.SIunits.Angle azi "Surface azimuth";
      parameter Boolean outSkyCon=false
        "Output contribution of diffuse irradiation from sky";
      parameter Boolean outGroCon=false
        "Output contribution of diffuse irradiation from ground";

      Modelica.Blocks.Math.Add add "Block to add radiations"
        annotation (Placement(transformation(extent={{60,-10},{80,10}})));
      Modelica.Blocks.Interfaces.RealOutput HSkyDifTil if outSkyCon
        "Hemispherical diffuse solar irradiation on a tilted surface from the sky"
        annotation (Placement(transformation(extent={{100,50},{120,70}})));
      Modelica.Blocks.Interfaces.RealOutput HGroDifTil if outGroCon
        "Hemispherical diffuse solar irradiation on a tilted surface from the ground"
        annotation (Placement(transformation(extent={{100,-70},{120,-50}})));

    protected
      DiffusePerez_sub HDifTil(final til=til, final rho=rho)
        "Diffuse irradiation on tilted surface"
        annotation (Placement(transformation(extent={{0,-21},{42,21}})));
      Buildings.BoundaryConditions.SolarIrradiation.BaseClasses.SkyClearness skyCle
        "Sky clearness"
        annotation (Placement(transformation(extent={{-62,16},{-54,24}})));
      Buildings.BoundaryConditions.SolarIrradiation.BaseClasses.BrighteningCoefficient
        briCoe "Brightening coefficient"
        annotation (Placement(transformation(extent={{-40,-34},{-32,-26}})));
      Buildings.BoundaryConditions.SolarIrradiation.BaseClasses.RelativeAirMass relAirMas
        "Relative air mass"
        annotation (Placement(transformation(extent={{-80,-44},{-72,-36}})));
      Buildings.BoundaryConditions.SolarIrradiation.BaseClasses.SkyBrightness skyBri
        "Sky brightness"
        annotation (Placement(transformation(extent={{-60,-54},{-52,-46}})));
      IncidenceAngle incAng(
        lat=lat,
        azi=azi,
        til=til) "Incidence angle"
        annotation (Placement(transformation(extent={{-86,-96},{-76,-86}})));

    equation
      connect(relAirMas.relAirMas, skyBri.relAirMas) annotation (Line(
          points={{-71.6,-40},{-66,-40},{-66,-48.4},{-60.8,-48.4}},
          color={0,0,127}));
      connect(skyBri.skyBri, briCoe.skyBri) annotation (Line(
          points={{-51.6,-50},{-46,-50},{-46,-30},{-40.8,-30}},
          color={0,0,127}));
      connect(skyCle.skyCle, briCoe.skyCle) annotation (Line(
          points={{-53.6,20},{-46,20},{-46,-27.6},{-40.8,-27.6}},
          color={0,0,127}));
      connect(incAng.y, HDifTil.incAng) annotation (Line(
          points={{-75.5,-91},{-16,-91},{-16,-16},{-4.2,-16},{-4.2,-14.7}},
          color={0,0,127}));
      connect(weaBus.solZen, skyCle.zen) annotation (Line(
          points={{-100,5.55112e-16},{-86,5.55112e-16},{-86,17.6},{-62.8,17.6}},
          color={0,0,127}));
      connect(weaBus.solZen, relAirMas.zen) annotation (Line(
          points={{-100,5.55112e-16},{-86,5.55112e-16},{-86,-40},{-80.8,-40}},
          color={0,0,127}));
      connect(weaBus.solZen, briCoe.zen) annotation (Line(
          points={{-100,5.55112e-16},{-86,5.55112e-16},{-86,-20},{-66,-20},{-66,-32},
              {-40.8,-32},{-40.8,-32.4}},
          color={0,0,127}));
      connect(weaBus.HGloHor, skyCle.HGloHor) annotation (Line(
          points={{-100,5.55112e-16},{-92,5.55112e-16},{-92,22.4},{-62.8,22.4}},
          color={255,204,51},
          thickness=0.5), Text(
          string="%first",
          index=-1,
          extent={{-6,3},{-6,3}}));
      connect(weaBus.HDifHor, skyCle.HDifHor) annotation (Line(
          points={{-100,5.55112e-16},{-92,5.55112e-16},{-92,20},{-62.8,20}},
          color={255,204,51},
          thickness=0.5), Text(
          string="%first",
          index=-1,
          extent={{-6,3},{-6,3}}));
      connect(weaBus.HDifHor, skyBri.HDifHor) annotation (Line(
          points={{-100,5.55112e-16},{-92,5.55112e-16},{-92,-51.6},{-60.8,-51.6}},
          color={255,204,51},
          thickness=0.5), Text(
          string="%first",
          index=-1,
          extent={{-6,3},{-6,3}}));
      connect(weaBus.HGloHor, HDifTil.HGloHor) annotation (Line(
          points={{-100,5.55112e-16},{-70,0},{-38,0},{-38,16.8},{-4.2,16.8}},
          color={255,204,51},
          thickness=0.5), Text(
          string="%first",
          index=-1,
          extent={{-6,3},{-6,3}}));
      connect(weaBus.HDifHor, HDifTil.HDifHor) annotation (Line(
          points={{-100,5.55112e-16},{-38,5.55112e-16},{-38,10},{-4.2,10},{-4.2,
              10.5}},
          color={255,204,51},
          thickness=0.5), Text(
          string="%first",
          index=-1,
          extent={{-6,3},{-6,3}}));

      connect(briCoe.F2, HDifTil.briCof2) annotation (Line(
          points={{-31.6,-31.6},{-24,-31.6},{-24,-2.1},{-4.2,-2.1}},
          color={0,0,127}));
      connect(briCoe.F1, HDifTil.briCof1) annotation (Line(
          points={{-31.6,-28.4},{-28,-28.4},{-28,4.2},{-4.2,4.2}},
          color={0,0,127}));
      connect(weaBus, incAng.weaBus) annotation (Line(
          points={{-100,5.55112e-016},{-92,5.55112e-016},{-92,-91},{-86,-91}},
          color={255,204,51},
          thickness=0.5), Text(
          string="%first",
          index=-1,
          extent={{-6,3},{-6,3}}));
      connect(weaBus.solZen, HDifTil.zen) annotation (Line(
          points={{-100,5.55112e-16},{-86,5.55112e-16},{-86,-58},{-20,-58},{-20,
              -8.4},{-4.2,-8.4}},
          color={255,204,51},
          thickness=0.5), Text(
          string="%first",
          index=-1,
          extent={{-6,3},{-6,3}}));
      connect(HDifTil.HSkyDifTil, add.u1) annotation (Line(
          points={{44.1,8.4},{52,8.4},{52,6},{58,6}},
          color={0,0,127}));
      connect(HDifTil.HGroDifTil, add.u2) annotation (Line(
          points={{44.1,-8.4},{52,-8.4},{52,-6},{58,-6}},
          color={0,0,127}));
      connect(add.y, H) annotation (Line(
          points={{81,6.10623e-16},{90.5,6.10623e-16},{90.5,5.55112e-16},{110,
              5.55112e-16}},
          color={0,0,127}));

      connect(HDifTil.HSkyDifTil, HSkyDifTil) annotation (Line(
          points={{44.1,8.4},{52,8.4},{52,60},{110,60}},
          color={0,0,127}));
      connect(HDifTil.HGroDifTil, HGroDifTil) annotation (Line(
          points={{44.1,-8.4},{52,-8.4},{52,-60},{110,-60}},
          color={0,0,127}));
      annotation (
        defaultComponentName="HDifTil",
        Documentation(info="<html>
<p>
This component computes the hemispherical diffuse irradiation on a tilted surface using an anisotropic
sky model proposed by Perez.
For a definition of the parameters, see the
<a href=\"modelica://Buildings.BoundaryConditions.UsersGuide\">User's Guide</a>.
</p>
<h4>References</h4>
<ul>
<li>
P. Ineichen, R. Perez and R. Seals (1987).
<i>The Importance of Correct Albedo Determination for Adequately Modeling Energy Received by Tilted Surface</i>,
Solar Energy, 39(4): 301-305.
</li>
<li>
R. Perez, R. Seals, P. Ineichen, R. Stewart and D. Menicucci (1987).
<i>A New Simplified Version of the Perez Diffuse Irradiance Model for Tilted Surface</i>,
Solar Energy, 39(3): 221-231.
</li>
<li>
R. Perez, P. Ineichen, R. Seals, J. Michalsky and R. Stewart (1990).
<i>Modeling Dyalight Availability and Irradiance Componets From Direct and Global Irradiance</i>,
Solar Energy, 44(5):271-289.
</li>
</ul>
</html>",     revisions="<html>
<ul>
<li>
November 14, 2015, by Michael Wetter:<br/>
Added <code>min</code>, <code>max</code> and <code>unit</code>
attributes for <code>rho</code>.
</li>
<li>
June 6, 2012, by Wangda Zuo:<br/>
Added contributions from sky and ground that were separated in base class.
</li>
<li>
February 25, 2012, by Michael Wetter:<br/>
Changed component to get zenith angle from weather bus.
</li>
<li>
May 24, 2010, by Wangda Zuo:<br/>
First implementation.
</li>
</ul>
</html>"),
        Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{100,
                100}}), graphics={Text(
              extent={{-150,110},{150,150}},
              textString="%name",
              lineColor={0,0,255})}));
    end DiffusePerez;

    block DirectTiltedSurface "Direct solar irradiation on a tilted surface"
      extends
        Buildings.BoundaryConditions.SolarIrradiation.BaseClasses.PartialSolarIrradiation;

      parameter Modelica.SIunits.Angle lat "Latitude";
      parameter Modelica.SIunits.Angle azi "Surface azimuth";

      Modelica.Blocks.Interfaces.RealOutput inc(
         quantity="Angle",
         unit="rad",
        displayUnit="deg") "Incidence angle"
        annotation (Placement(transformation(extent={{100,-50},{120,-30}})));

    protected
      IncidenceAngle incAng(
        azi=azi,
        til=til,
        lat=lat) "Incidence angle"
        annotation (Placement(transformation(extent={{-50,-30},{-30,-10}})));
      DirectTiltedSurface_sub HDirTil "Direct irradition on tilted surface"
        annotation (Placement(transformation(extent={{0,-20},{40,20}})));

    equation
      connect(incAng.y, HDirTil.incAng) annotation (Line(
          points={{-29,-20},{-12,-20},{-12,-12},{-4,-12}},
          color={0,0,127}));

      connect(weaBus.HDirNor, HDirTil.HDirNor) annotation (Line(
          points={{-100,5.55112e-16},{-80,5.55112e-16},{-80,12},{-4,12}},
          color={255,204,51},
          thickness=0.5), Text(
          string="%first",
          index=-1,
          extent={{-6,3},{-6,3}}));
      connect(incAng.y, inc) annotation (Line(
          points={{-29,-20},{-20,-20},{-20,-40},{110,-40}},
          color={0,0,127}));
      connect(HDirTil.HDirTil, H) annotation (Line(
          points={{42,1.22125e-15},{72,1.22125e-15},{72,5.55112e-16},{110,
              5.55112e-16}},
          color={0,0,127}));

      connect(weaBus, incAng.weaBus) annotation (Line(
          points={{-100,5.55112e-16},{-80,5.55112e-16},{-80,-20},{-50,-20}},
          color={255,204,51},
          thickness=0.5), Text(
          string="%first",
          index=-1,
          extent={{-6,3},{-6,3}}));
      annotation (
        defaultComponentName="HDirTil",
        Documentation(info="<html>
<p>
This component computes the direct solar irradiation on a tilted surface.
For a definition of the parameters, see the
<a href=\"modelica://Buildings.BoundaryConditions.UsersGuide\">User's Guide</a>.
</p>
</html>",     revisions="<html>
<ul>
<li>
April 21, 2016, by Michael Wetter:<br/>
Removed duplicate instance <code>weaBus</code>.
This is for
<a href=\"https://github.com/ibpsa/modelica/issues/461\">
https://github.com/ibpsa/modelica/issues/461</a>.
</li>
<li>
December 12, 2010, by Michael Wetter:<br/>
Added incidence angle as output as this is needed for the room model.
</li>
<li>
May 24, 2010, by Wangda Zuo:<br/>
First implementation.
</li>
</ul>
</html>"),
        Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{100,
                100}}), graphics={Text(
              extent={{-150,110},{150,150}},
              textString="%name",
              lineColor={0,0,255})}));
    end DirectTiltedSurface;

    block IncidenceAngle "Solar incidence angle on a tilted surface"
      extends Modelica.Blocks.Icons.Block;
      parameter Modelica.SIunits.Angle lat "Latitude";
      parameter Modelica.SIunits.Angle azi "Surface azimuth";
      parameter Modelica.SIunits.Angle til "Surface tilt";

      Modelica.Blocks.Interfaces.RealOutput y(
        quantity="Angle",
        unit="rad",
        displayUnit="deg") "Incidence angle" annotation (Placement(transformation(
              extent={{100,-10},{120,10}}), iconTransformation(extent={{100,-10},{
                120,10}})));
      Buildings.BoundaryConditions.WeatherData.Bus weaBus "Weather data"
        annotation (Placement(transformation(extent={{-110,-10},{-90,10}})));
    protected
      Buildings.BoundaryConditions.SolarGeometry.BaseClasses.Declination decAng
        "Declination angle"
        annotation (Placement(transformation(extent={{-40,30},{-20,50}})));
      Buildings.BoundaryConditions.SolarGeometry.BaseClasses.SolarHourAngle
        solHouAng "Solar hour angle"
        annotation (Placement(transformation(extent={{-40,-50},{-20,-30}})));
      Buildings.BoundaryConditions.SolarGeometry.BaseClasses.IncidenceAngle incAng(
        lat=lat,
        azi=azi,
        til=til) "Incidence angle"
        annotation (Placement(transformation(extent={{40,-10},{60,10}})));
    equation
      connect(incAng.incAng, y) annotation (Line(
          points={{61,0},{88.25,0},{88.25,1.16573e-015},{95.5,1.16573e-015},{95.5,0},
              {110,0}},
          color={0,0,127}));
      connect(decAng.decAng, incAng.decAng) annotation (Line(
          points={{-19,40},{20,40},{20,5.4},{37.8,5.4}},
          color={0,0,127}));
      connect(solHouAng.solHouAng, incAng.solHouAng) annotation (Line(
          points={{-19,-40},{20,-40},{20,-4.8},{38,-4.8}},
          color={0,0,127}));
      connect(weaBus.cloTim, decAng.nDay) annotation (Line(
          points={{-100,0},{-80,0},{-80,40},{-42,40}},
          color={255,204,51},
          thickness=0.5), Text(
          string="%first",
          index=-1,
          extent={{-6,3},{-6,3}}));
      connect(weaBus.solTim, solHouAng.solTim) annotation (Line(
          points={{-100,0},{-80,0},{-80,-40},{-42,-40}},
          color={255,204,51},
          thickness=0.5), Text(
          string="%first",
          index=-1,
          extent={{-6,3},{-6,3}}));
      annotation (
        defaultComponentName="incAng",
        Documentation(info="<html>
<p>
This component computes the solar incidence angle on a tilted surface.
For a definition of the parameters, see the User's Guide
<a href=\"modelica://Buildings.BoundaryConditions.UsersGuide\">Buildings.BoundaryConditions.UsersGuide</a>.
</p>
</html>",     revisions="<html>
<ul>
<li>
November 30, 2011, by Michael Wetter:<br/>
Removed <code>connect(y, y)</code> statement.
</li>
<li>
February 28, 2011, by Wangda Zuo:<br/>
Use local civil time instead of clock time.
</li>
<li>
May 19, 2010, by Wangda Zuo:<br/>
First implementation.
</li>
</ul>
</html>"),
        Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{100,
                100}}), graphics={Text(
              extent={{-150,110},{150,150}},
              textString="%name",
              lineColor={0,0,255}), Bitmap(extent={{-90,90},{90,-92}}, fileName=
                  "modelica://Buildings/Resources/Images/BoundaryConditions/SolarGeometry/BaseClasses/IncidenceAngle.png")}));
    end IncidenceAngle;

    block DirectTiltedSurface_sub "Direct solar irradiation on a tilted surface"
      extends Modelica.Blocks.Icons.Block;
      Modelica.Blocks.Interfaces.RealInput incAng(
        quantity="Angle",
        unit="rad",
        displayUnit="degree") "Incidence angle of the sun beam on a tilted surface"
        annotation (Placement(transformation(extent={{-140,-80},{-100,-40}})));
      Modelica.Blocks.Interfaces.RealInput HDirNor(quantity=
            "RadiantEnergyFluenceRate", unit="W/m2") "Direct normal radiation"
        annotation (Placement(transformation(extent={{-140,40},{-100,80}})));
      Modelica.Blocks.Interfaces.RealOutput HDirTil(quantity=
            "RadiantEnergyFluenceRate", unit="W/m2")
        "Direct solar irradiation on a tilted surface"
        annotation (Placement(transformation(extent={{100,-10},{120,10}})));

    equation
      HDirTil =  max(0, Modelica.Math.cos(incAng)*HDirNor);
      annotation (
        defaultComponentName="HDirTil",
        Documentation(info="<html>
<p>
This component computes the direct solar irradiation on a tilted surface.
</p>
</html>",     revisions="<html>
<ul>
<li>
May 5, 2015, by Filip Jorissen:<br/>
Converted <code>algorithm</code> section into
<code>equation</code> section for easier differentiability.
</li>
<li>
May 24, 2010, by Wangda Zuo:<br/>
First implementation.
</li>
</ul>
</html>"),
        Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{100,
                100}}), graphics={
            Text(
              extent={{-150,110},{150,150}},
              textString="%name",
              lineColor={0,0,255}),
            Text(
              extent={{-50,56},{-102,68}},
              lineColor={0,0,127},
              textString="HDirNor"),
            Text(
              extent={{-54,-66},{-106,-54}},
              lineColor={0,0,127},
              textString="incAng")}));
    end DirectTiltedSurface_sub;

    block DiffusePerez_sub
      "Hemispherical diffuse irradiation on a tilted surface with Perez's anisotropic model"
      extends Modelica.Blocks.Icons.Block;
      parameter Real rho=0.2 "Ground reflectance";
      parameter Modelica.SIunits.Angle til(displayUnit="deg") "Surface tilt angle";
      Modelica.Blocks.Interfaces.RealInput briCof1 "Brightening Coeffcient F1"
        annotation (Placement(transformation(extent={{-140,0},{-100,40}})));
      Modelica.Blocks.Interfaces.RealInput briCof2 "Brightening Coeffcient F2"
        annotation (Placement(transformation(extent={{-140,-30},{-100,10}})));
      Modelica.Blocks.Interfaces.RealInput HDifHor(quantity=
            "RadiantEnergyFluenceRate", unit="W/m2")
        "Diffuse horizontal solar radiation"
        annotation (Placement(transformation(extent={{-140,30},{-100,70}})));
      Modelica.Blocks.Interfaces.RealInput HGloHor(quantity=
            "RadiantEnergyFluenceRate", unit="W/m2") "Global horizontal radiation"
        annotation (Placement(transformation(extent={{-140,60},{-100,100}})));

      Modelica.Blocks.Interfaces.RealInput zen(
        quantity="Angle",
        unit="rad",
        displayUnit="degree") "Zenith angle of the sun beam"
        annotation (Placement(transformation(extent={{-140,-60},{-100,-20}})));
      Modelica.Blocks.Interfaces.RealInput incAng(
        quantity="Angle",
        unit="rad",
        displayUnit="degree") "Solar incidence angle on the surface"
        annotation (Placement(transformation(extent={{-140,-90},{-100,-50}})));

      Modelica.Blocks.Interfaces.RealOutput HGroDifTil(final quantity=
            "RadiantEnergyFluenceRate", final unit="W/m2")
        "Hemispherical diffuse solar irradiation on a tilted surface from the ground"
        annotation (Placement(transformation(extent={{100,-50},{120,-30}})));
      Modelica.Blocks.Interfaces.RealOutput HSkyDifTil(final quantity=
            "RadiantEnergyFluenceRate", final unit="W/m2")
        "Hemispherical diffuse solar irradiation on a tilted surface from the sky"
        annotation (Placement(transformation(extent={{100,30},{120,50}})));
    protected
      Real a;
      Real b;
      constant Real bMin=Modelica.Math.cos(Modelica.Constants.pi*85/180)
        "Lower bound for b";
    equation
      a = Buildings.Utilities.Math.Functions.smoothMax(
        0,
        Modelica.Math.cos(incAng),
        0.01);
      b = Buildings.Utilities.Math.Functions.smoothMax(
        bMin,
        Modelica.Math.cos(zen),
        0.01);
      HSkyDifTil = HDifHor*(0.5*(1 - briCof1)*(1 + Modelica.Math.cos(til)) +
        briCof1*a/b + briCof2*Modelica.Math.sin(til));
      HGroDifTil = HGloHor*0.5*rho*(1 - Modelica.Math.cos(til));

      annotation (
        defaultComponentName="HDifTil",
        Documentation(info="<html>
<p>
This component computes the hemispherical diffuse irradiation on a tilted surface by using an anisotropic model proposed by Perez.
</p>
<h4>References</h4>
<ul>
<li>
P. Ineichen, R. Perez and R. Seals (1987).
<i>The Importance of Correct Albedo Determination for Adequately Modeling Energy Received by Tilted Surface</i>,
Solar Energy, 39(4): 301-305.
</li>
<li>
R. Perez, R. Seals, P. Ineichen, R. Stewart and D. Menicucci (1987).
<i>A New Simplified Version of the Perez Diffuse Irradiance Model for Tilted Surface</i>,
Solar Energy, 39(3): 221-231.
</li>
<li>
R. Perez, P. Ineichen, R. Seals, J. Michalsky and R. Stewart (1990).
<i>Modeling Dyalight Availability and Irradiance Componets From Direct and Global Irradiance</i>,
Solar Energy, 44(5):271-289.
</li>
</ul>
</html>",     revisions="<html>
<ul>
<li>
June 6, 2012, by Wangda Zuo:<br/>
Separated the contribution from the sky and the ground.
</li>
</ul>
<ul>
<li>
May 24, 2010, by Wangda Zuo:<br/>
First implementation.
</li>
</ul>
</html>"),
        Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{100,
                100}}), graphics={
            Text(
              extent={{-150,110},{150,150}},
              textString="%name",
              lineColor={0,0,255}),
            Text(
              extent={{-48,74},{-100,86}},
              lineColor={0,0,127},
              textString="HGloHor"),
            Text(
              extent={{-50,44},{-102,56}},
              lineColor={0,0,127},
              textString="HDifHor"),
            Text(
              extent={{-50,14},{-102,26}},
              lineColor={0,0,127},
              textString="briCof1"),
            Text(
              extent={{-50,-16},{-102,-4}},
              lineColor={0,0,127},
              textString="briCof2"),
            Text(
              extent={{-50,-46},{-102,-34}},
              lineColor={0,0,127},
              textString="zen"),
            Text(
              extent={{-52,-76},{-104,-64}},
              lineColor={0,0,127},
              textString="incAng")}));
    end DiffusePerez_sub;

    package Examples

      model PvOrientated_compareModels
        parameter Real A_PV=1 "Area of PV system";
        parameter Real til=10 "Surface tilt [deg]";
        parameter Real azi=0 "Surface azimuth [deg]";
        parameter String filNam="C:/Users/Christoph/Documents/GitHub/cyder/hil/controls/USA_CA_San.Francisco.Intl.AP.724940_TMY3.mos";
        //parameter String filNam="USA_CA_San.Francisco.Intl.AP.724940_TMY3.mos";

        Buildings.BoundaryConditions.WeatherData.ReaderTMY3
                                                  weaDat(
            computeWetBulbTemperature=false, filNam=
              filNam)
          "Weather data model"
          annotation (Placement(transformation(extent={{-80,40},{-60,60}})));
        Buildings.Electrical.AC.OnePhase.Sources.PVSimpleOriented pv_buildings(
          pf=1,
          V_nominal=120,
          A=A_PV,
          azi=Modelica.SIunits.Conversions.from_deg(azi),
          til=Modelica.SIunits.Conversions.from_deg(til),
          lat=weaDat.lat)
          annotation (Placement(transformation(extent={{4,-10},{24,10}})));
        Buildings.Electrical.AC.OnePhase.Sources.FixedVoltage fixVol(f=60, V=120)
          annotation (Placement(transformation(extent={{-60,-10},{-40,10}})));
        CyDER.PvModel.Models.PV_simple_tilted pV_smartinverter(
          lat=Modelica.SIunits.Conversions.to_deg(weaDat.lat),
          A=A_PV,
          til=til,
          azi=azi) annotation (Placement(transformation(extent={{0,-40},{20,-20}})));
        Modelica.Blocks.Sources.Constant shading(k=0)
          annotation (Placement(transformation(extent={{-60,-40},{-40,-20}})));
      protected
        Buildings.BoundaryConditions.SolarIrradiation.DiffusePerez HDifTil_buildings(
          final til=Modelica.SIunits.Conversions.from_deg(til),
          final lat=weaDat.lat,
          final azi=Modelica.SIunits.Conversions.from_deg(azi)) "Diffuse irradiation on tilted surface"
          annotation (Placement(transformation(extent={{40,62},{60,82}})));
        Buildings.BoundaryConditions.SolarIrradiation.DirectTiltedSurface HDirTil_buildings(
          final til=Modelica.SIunits.Conversions.from_deg(til),
          final lat=weaDat.lat,
          final azi=Modelica.SIunits.Conversions.from_deg(azi)) "Direct irradiation on tilted surface"
          annotation (Placement(transformation(extent={{40,35},{60,55}})));
      public
        DiffusePerez HDifTil_smartinverter(
          azi=Modelica.SIunits.Conversions.from_deg(azi),
          til=Modelica.SIunits.Conversions.from_deg(til),
          lat=weaDat.lat) "Diffuse irradiation on tilted surface"
          annotation (Placement(transformation(extent={{40,-60},{60,-40}})));
        DirectTiltedSurface HDirTil_smartinverter(
          azi=Modelica.SIunits.Conversions.from_deg(azi),
          til=Modelica.SIunits.Conversions.from_deg(til),
          lat=weaDat.lat) "Direct irradiation on tilted surface"
          annotation (Placement(transformation(extent={{42,-86},{62,-66}})));
      equation
        connect(weaDat.weaBus, pv_buildings.weaBus) annotation (Line(
            points={{-60,50},{14,50},{14,9}},
            color={255,204,51},
            thickness=0.5));
        connect(fixVol.terminal, pv_buildings.terminal)
          annotation (Line(points={{-40,0},{4,0}},   color={0,120,120}));
        connect(shading.y, pV_smartinverter.Shading) annotation (Line(points={{-39,-30},
                {-30,-30},{-30,-34},{-2,-34}}, color={0,0,127}));
        connect(pV_smartinverter.weaBus, pv_buildings.weaBus) annotation (Line(
            points={{0,-30},{-24,-30},{-24,50},{14,50},{14,9}},
            color={255,204,51},
            thickness=0.5));
        connect(HDifTil_buildings.weaBus, pv_buildings.weaBus) annotation (Line(
            points={{40,72},{28,72},{28,50},{14,50},{14,9}},
            color={255,204,51},
            thickness=0.5));
        connect(HDirTil_buildings.weaBus, pv_buildings.weaBus) annotation (Line(
            points={{40,45},{32,45},{32,50},{14,50},{14,9}},
            color={255,204,51},
            thickness=0.5));
        connect(HDifTil_smartinverter.weaBus, pv_buildings.weaBus) annotation (Line(
            points={{40,-50},{8,-50},{8,-30},{-24,-30},{-24,50},{14,50},{14,9}},
            color={255,204,51},
            thickness=0.5));
        connect(HDirTil_smartinverter.weaBus, pv_buildings.weaBus) annotation (Line(
            points={{42,-76},{6,-76},{6,-30},{-28,-30},{-28,50},{14,50},{14,9}},
            color={255,204,51},
            thickness=0.5));
        annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
              coordinateSystem(preserveAspectRatio=false)));
      end PvOrientated_compareModels;
    end Examples;

    model TiltedSolarWeabus
      parameter Real lat=37.9 "Latitude [deg]";
      parameter Real til=0 "Surface tilt [deg]";
      parameter Real azi=0 "Surface azimuth [deg] 0-S, 90-W, 180-N, 270-E ";

      Solar.DiffusePerez                               HDifTil(
        azi=Modelica.SIunits.Conversions.from_deg(azi),
        til=Modelica.SIunits.Conversions.from_deg(til),
        lat=Modelica.SIunits.Conversions.from_deg(lat)) "Diffuse irradiation on tilted surface"
        annotation (Placement(transformation(extent={{-20,10},{0,30}})));
      Solar.DirectTiltedSurface                               HDirTil(
        azi=Modelica.SIunits.Conversions.from_deg(azi),
        til=Modelica.SIunits.Conversions.from_deg(til),
        lat=Modelica.SIunits.Conversions.from_deg(lat)) "Direct irradiation on tilted surface"
        annotation (Placement(transformation(extent={{-20,-30},{0,-10}})));
      Modelica.Blocks.Math.Add sum "Total irradiation on tilted surface"
        annotation (Placement(transformation(
            extent={{10,-10},{-10,10}},
            rotation=180,
            origin={50,0})));
      Modelica.Blocks.Interfaces.RealOutput G(final quantity="RadiantEnergyFluenceRate",
          final unit="W/m2") "Tilted Solar Radiation"
        annotation (Placement(transformation(extent={{100,-10},{120,10}})));
      Buildings.BoundaryConditions.WeatherData.Bus
                      weaBus "Bus with weather data"
        annotation (Placement(transformation(extent={{-110,-10},{-90,10}})));
    equation
      connect(sum.u2, HDifTil.H)
        annotation (Line(points={{38,6},{20,6},{20,20},{1,20}}, color={0,0,127}));
      connect(sum.u1, HDirTil.H) annotation (Line(points={{38,-6},{20,-6},{20,-20},{
              1,-20}}, color={0,0,127}));
      connect(sum.y, G) annotation (Line(points={{61,0},{110,0}}, color={0,0,127}));
      connect(HDifTil.weaBus, weaBus) annotation (Line(
          points={{-20,20},{-60,20},{-60,0},{-100,0}},
          color={255,204,51},
          thickness=0.5), Text(
          string="%second",
          index=1,
          extent={{6,3},{6,3}}));
      connect(HDirTil.weaBus, weaBus) annotation (Line(
          points={{-20,-20},{-60,-20},{-60,0},{-100,0}},
          color={255,204,51},
          thickness=0.5), Text(
          string="%second",
          index=1,
          extent={{6,3},{6,3}}));
      annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
            coordinateSystem(preserveAspectRatio=false)));
    end TiltedSolarWeabus;
  end Solar;

  package Components

    package Sensor

      package Model

        model Probe3ph
          parameter Modelica.SIunits.Voltage V_nominal = 208;
          Buildings.Electrical.AC.ThreePhasesUnbalanced.Interfaces.Terminal_n terminal_n
            "Electrical connector side N"
            annotation (Placement(transformation(extent={{-110,-10},{-90,10}})));
          Modelica.Blocks.Interfaces.RealOutput Vy[3](each final quantity=
                "ElectricPotential", each final unit="V")
            "Voltage Line to Neutral" annotation (Placement(transformation(
                extent={{-10,-10},{10,10}},
                rotation=270,
                origin={10,-40}), iconTransformation(
                extent={{-10,-10},{10,10}},
                rotation=270,
                origin={-90,-90})));
          Modelica.Blocks.Interfaces.RealOutput I[3](each final quantity="ElectricCurrent",
                                                  each final unit="A") "Phase Current"           annotation (Placement(
                transformation(
                extent={{-10,-10},{10,10}},
                rotation=270,
                origin={70,-40}), iconTransformation(
                extent={{-10,-10},{10,10}},
                rotation=270,
                origin={-70,-90})));
          Modelica.Blocks.Interfaces.RealOutput S_old[3,Buildings.Electrical.PhaseSystems.OnePhase.n](
             each final quantity="Power", each final unit="W") "Phase powers"
            annotation (Placement(transformation(
                extent={{-10,-10},{10,10}},
                rotation=270,
                origin={-50,-40}), iconTransformation(
                extent={{-10,-10},{10,10}},
                rotation=270,
                origin={70,-90})));
          Modelica.Blocks.Interfaces.RealOutput Test(final quantity="Power", final
                    unit="VA") "Phase powers" annotation (Placement(transformation(
                extent={{-10,-10},{10,10}},
                rotation=270,
                origin={-10,-70}), iconTransformation(
                extent={{-10,-10},{10,10}},
                rotation=270,
                origin={90,-90})));

          Modelica.Blocks.Interfaces.RealOutput T1[3](each final quantity="Angle", each final
                    unit="rad") "Test";
          Modelica.Blocks.Interfaces.RealOutput T2[3](each final quantity="Angle", each final
                    unit="rad") "Test";
          Buildings.Electrical.AC.ThreePhasesUnbalanced.Interfaces.Terminal_p
                                terminal_p "Electrical connector side P"
            annotation (Placement(transformation(extent={{90,-10},{110,10}})));

          Modelica.Blocks.Interfaces.RealOutput P[3](each final quantity="ActivePower",
           each final unit="W") "Phase Active Power" annotation (Placement(transformation(
                extent={{-10,-10},{10,10}},
                rotation=270,
                origin={22,-68}), iconTransformation(
                extent={{-10,-10},{10,10}},
                rotation=270,
                origin={-30,-90})));
          Modelica.Blocks.Interfaces.RealOutput S[3](each final quantity="ApparentPower",
              each final unit="VA") "Phase Apparent Power" annotation (Placement(
                transformation(
                extent={{-10,-10},{10,10}},
                rotation=270,
                origin={48,-68}), iconTransformation(
                extent={{-10,-10},{10,10}},
                rotation=270,
                origin={-50,-90})));
          Modelica.Blocks.Interfaces.RealOutput Q[3](each final quantity="ReactivePower",
           each final unit="var") "Phase Reactive Power" annotation (Placement(transformation(
                extent={{-10,-10},{10,10}},
                rotation=270,
                origin={-56,-66}), iconTransformation(
                extent={{-10,-10},{10,10}},
                rotation=270,
                origin={-10,-90})));
          Modelica.Blocks.Interfaces.RealOutput PF[3](each final quantity="PowerFactor",
           each final unit="") "Phase Power Factor" annotation (Placement(transformation(
                extent={{-10,-10},{10,10}},
                rotation=270,
                origin={-88,-66}),iconTransformation(
                extent={{-10,-10},{10,10}},
                rotation=270,
                origin={10,-90})));
          Modelica.Blocks.Interfaces.RealOutput V_pu[3](each final quantity="ElectricPotential",
           each final unit="V") "Phase Voltage per Unit";

        equation

          for i in 1:3 loop
            Vy[i] = Buildings.Electrical.PhaseSystems.OnePhase.systemVoltage(
              terminal_n.phase[i].v);
            V_pu[i] = Buildings.Electrical.PhaseSystems.OnePhase.systemVoltage(terminal_n.phase[i].v) / (V_nominal / sqrt(3));
            I[i]   = Buildings.Electrical.PhaseSystems.OnePhase.systemCurrent(terminal_n.phase[i].i);
            S_old[i, :] = Buildings.Electrical.PhaseSystems.OnePhase.phasePowers_vi(v=
              terminal_n.phase[i].v, i=terminal_n.phase[i].i);
            P[i] = S_old[i, 1];
            Q[i] = S_old[i, 2];
            //if S[i] > P[i] then
            S[i] = sqrt(P[i]^2 + Q[i]^2) * P[i]/sqrt(P[i]^2 + 1e-9);
            //else
            //  S[i] = 99;
            //end if;
            PF[i] = P[i] / (S[i] + 1e-9);
            //P[i] = Buildings.Electrical.PhaseSystems.OnePhase.activePower(v=terminal_n.phase[i].v, i=terminal_n.phase[i].i);
            //  Modelica.SIunits.Angle phi=
            //T1[i] = Buildings.Electrical.PhaseSystems.OnePhase.phase(terminal_n.phase[i].v) - Buildings.Electrical.PhaseSystems.OnePhase.phase(-terminal_n.phase[i].i);
            T1[i] = Buildings.Electrical.PhaseSystems.OnePhase.phase(terminal_n.phase[i].v);
            //T2[i] = Buildings.Electrical.PhaseSystems.OnePhase.phase(terminal_n.phase[i].i);
            //T2[i] = mod(terminal_n.phase[i].theta[1],360);

            T2[i] = terminal_n.phase[i].theta[1];

            //T2[i] = Modelica.ComplexMath.sin(terminal_n.phase[i].v);
            //T2[i] = 0;
            //T1[i] = 0;

            //Test[i] = PhaseSystem.phase(terminal.v) - PhaseSystem.phase(-terminal.i);
            //"Phase shift with respect to reference angle";
            //Test[i] = Buildings.Electrical.PhaseSystems.OnePhase.thetaRel(terminal_n.phase[i].theta);
          end for;
          //Test = terminal_n.phase[1];
          Test = 1;

          connect(terminal_n, terminal_p);
          annotation (defaultComponentName="sens",
         Icon(graphics={
                Rectangle(
                  extent={{-70,28},{70,-30}},
                  lineColor={0,0,0},
                  fillColor={255,255,255},
                  fillPattern=FillPattern.Solid),
                Ellipse(
                  extent={{-60,60},{60,-60}},
                  lineColor={0,0,0},
                  fillColor={255,255,255},
                  fillPattern=FillPattern.Solid),
                Line(
                  points={{-92,0},{-70,0}},
                  color={0,0,0},
                  smooth=Smooth.None),
                Text(
                  extent={{-100,-60},{-80,-80}},
                  lineColor={0,0,0},
                  lineThickness=1,
                  fillColor={255,255,255},
                  fillPattern=FillPattern.Solid,
                  textString="V"),
                Polygon(
                  points={{-0.48,33.6},{18,28},{18,59.2},{-0.48,33.6}},
                  lineColor={0,0,0},
                  fillColor={0,0,0},
                  fillPattern=FillPattern.Solid),
                Line(points={{-37.6,15.7},{-54,22}},     color={0,0,0}),
                Line(points={{-22.9,34.8},{-32,50}},     color={0,0,0}),
                Line(points={{0,60},{0,42}}, color={0,0,0}),
                Line(points={{22.9,34.8},{32,50}},     color={0,0,0}),
                Line(points={{37.6,15.7},{54,24}},     color={0,0,0}),
                Line(points={{0,2},{9.02,30.6}}, color={0,0,0}),
                Ellipse(
                  extent={{-5,7},{5,-3}},
                  lineColor={0,0,0},
                  fillColor={0,0,0},
                  fillPattern=FillPattern.Solid),
                Line(
                  points={{70,0},{92,0}},
                  color={0,0,0},
                  smooth=Smooth.None),
                Text(
                  extent={{-120,100},{120,60}},
                  lineColor={0,0,0},
                  textString="%name"),
                Text(
                  extent={{-80,-60},{-60,-80}},
                  lineColor={0,0,0},
                  lineThickness=1,
                  fillColor={255,255,255},
                  fillPattern=FillPattern.Solid,
                  textString="I"),
                Text(
                  extent={{-60,-60},{-40,-80}},
                  lineColor={0,0,0},
                  lineThickness=1,
                  fillColor={255,255,255},
                  fillPattern=FillPattern.Solid,
                  textString="S"),
                Text(
                  extent={{-40,-60},{-20,-80}},
                  lineColor={0,0,0},
                  lineThickness=1,
                  fillColor={255,255,255},
                  fillPattern=FillPattern.Solid,
                  textString="P"),
                Text(
                  extent={{-20,-60},{0,-80}},
                  lineColor={0,0,0},
                  lineThickness=1,
                  fillColor={255,255,255},
                  fillPattern=FillPattern.Solid,
                  textString="Q"),
                Text(
                  extent={{0,-60},{20,-80}},
                  lineColor={0,0,0},
                  lineThickness=1,
                  fillColor={255,255,255},
                  fillPattern=FillPattern.Solid,
                  textString="PF"),
                Text(
                  extent={{60,-60},{80,-80}},
                  lineColor={0,0,0},
                  lineThickness=1,
                  fillColor={255,255,255},
                  fillPattern=FillPattern.Solid,
                  textString="SX"),
                Text(
                  extent={{80,-60},{100,-80}},
                  lineColor={0,0,0},
                  lineThickness=1,
                  fillColor={255,255,255},
                  fillPattern=FillPattern.Solid,
                  textString="X")}),
            Documentation(info="<html>
<p>
Ideal sensor that measures power, voltage and current in a three-phase unbalanced system
without a neutral cable.
The two components of the power <i>S</i> are the active and reactive power for each phase.
</p>
</html>",         revisions="<html>
<ul>
<li>
November 8, 2016, by Michael Wetter:<br/>
Corrected wrong access to phase system.<br/>
This is for
<a href=\"https://github.com/lbl-srg/modelica-buildings/issues/570\">#570</a>.
</li>
<li>
September 24, 2014, by Marco Bonvini:<br/>
Revised documentation.
</li>
</ul>
</html>"));
        end Probe3ph;
      end Model;

      package Examples
        extends Modelica.Icons.ExamplesPackage;
        model Test_Probe3ph

          Model.Probe3ph sens_resistive
            annotation (Placement(transformation(extent={{-40,50},{-20,70}})));
          Buildings.Electrical.AC.ThreePhasesUnbalanced.Sources.FixedVoltage source(f=60, V=
                208)
            annotation (Placement(transformation(extent={{10,-10},{-10,10}},
                rotation=180,
                origin={-90,0})));
          Model.Probe3ph sens_inductive
            annotation (Placement(transformation(extent={{-40,10},{-20,30}})));
          Model.Probe3ph sens_capacitive
            annotation (Placement(transformation(extent={{-40,-30},{-20,-10}})));
          Model.Probe3ph sens_impedance
            annotation (Placement(transformation(extent={{-40,-70},{-20,-50}})));
          Buildings.Electrical.AC.ThreePhasesUnbalanced.Loads.Resistive
            load_resistive(P_nominal=1000, V_nominal=208)
            annotation (Placement(transformation(extent={{20,50},{40,70}})));
          Buildings.Electrical.AC.ThreePhasesUnbalanced.Loads.Inductive
            load_inductive(
            V_nominal=208,
            P_nominal=1000,
            pf=0.1)
            annotation (Placement(transformation(extent={{20,10},{40,30}})));
          Buildings.Electrical.AC.ThreePhasesUnbalanced.Loads.Capacitive
            load_capacitive(
            P_nominal=1000,
            V_nominal=208,
            pf=0.1)
            annotation (Placement(transformation(extent={{20,-30},{40,-10}})));
          Buildings.Electrical.AC.ThreePhasesUnbalanced.Loads.Impedance
            load_impedance
            annotation (Placement(transformation(extent={{20,-70},{40,-50}})));
        equation
          connect(source.terminal, sens_impedance.terminal_n) annotation (Line(
                points={{-80,0},{-60,0},{-60,-60},{-40,-60}}, color={0,120,120}));
          connect(sens_capacitive.terminal_n, source.terminal) annotation (Line(
                points={{-40,-20},{-60,-20},{-60,0},{-80,0}}, color={0,120,120}));
          connect(sens_inductive.terminal_n, source.terminal) annotation (Line(
                points={{-40,20},{-60,20},{-60,0},{-80,0}}, color={0,120,120}));
          connect(sens_resistive.terminal_n, source.terminal) annotation (Line(
                points={{-40,60},{-60,60},{-60,0},{-80,0}}, color={0,120,120}));
          connect(sens_resistive.terminal_p, load_resistive.terminal) annotation (
             Line(points={{-20,60},{0,60},{20,60}}, color={0,120,120}));
          connect(sens_inductive.terminal_p, load_inductive.terminal) annotation (
             Line(points={{-20,20},{0,20},{20,20}}, color={0,120,120}));
          connect(sens_capacitive.terminal_p, load_capacitive.terminal)
            annotation (Line(points={{-20,-20},{0,-20},{20,-20}}, color={0,120,
                  120}));
          connect(sens_impedance.terminal_p, load_impedance.terminal) annotation (
             Line(points={{-20,-60},{0,-60},{20,-60}}, color={0,120,120}));
          annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
                coordinateSystem(preserveAspectRatio=false)));
        end Test_Probe3ph;
      end Examples;
    end Sensor;

    package Inverter

      package Model

        model Inverter
          import Flexgrid = SCooDER;
          parameter Modelica.SIunits.Voltage V_nominal(min=0, start=240) = 240
            "Nominal voltage";
          parameter Real etaPV(min=0, max=1, unit="1") = 0.988*0.974
            "Conversion efficiency for PV";
          parameter Real etaBatt(min=0, max=1, unit="1") = 0.974
            "Conversion efficiency for battery";
          parameter Real delayP(unit="s") = 0.03
            "Time constant for Active Power control";
          parameter Real delayQ(unit="s") = 0.03
            "Time constant for Reactive Power control";
          parameter Real delaybattery(unit="s") = 0.03
            "Time constant for Battery control";
          parameter Real Smax(min=0, unit="VA") = 7600
            "Maximal apparent power";
          parameter Real QIndmax(min=0, unit="var") = 3300
            "Maximal reactive power (Inductive)";
          parameter Real QCapmax(min=0, unit="var") = 3300
            "Maximal reactive power (Capacitive)";

          Buildings.Electrical.AC.OnePhase.Interfaces.Terminal_n term_p
            annotation (Placement(transformation(extent={{-110,-10},{-90,10}})));
          Modelica.Blocks.Interfaces.RealInput P_PV(unit="W")
            "Power generation from PV (pos if produced)" annotation (Placement(
                transformation(
                extent={{-20,-20},{20,20}},
                rotation=180,
                origin={120,60}), iconTransformation(
                extent={{-20,-20},{20,20}},
                rotation=180,
                origin={120,60})));
          Modelica.Blocks.Interfaces.RealInput P_Batt(unit="W")
            "Power to/from Battery (pos if produced)" annotation (Placement(
                transformation(
                extent={{-20,-20},{20,20}},
                rotation=180,
                origin={120,-30}), iconTransformation(
                extent={{-20,-20},{20,20}},
                rotation=180,
                origin={120,-30})));
          Buildings.Electrical.AC.OnePhase.Sensors.GeneralizedSensor sens_Inverter
            annotation (Placement(transformation(extent={{-10,10},{10,-10}},
                rotation=90,
                origin={-80,30})));
          Flexgrid.Components.Inverter.Model.InverterLoad_PQ Load(V_nominal=120)
            "Negative (inductive/capacitive) load to simulate Inverter"
            annotation (Placement(transformation(extent={{-70,40},{-50,60}})));
          Modelica.Blocks.Sources.RealExpression ReactivePower_Ctrl(y=q_ctrl)
            "Controlled q with constraints"
            annotation (Placement(transformation(extent={{-10,60},{-30,80}})));
          Real q_ctrl;
          Real active_pv( start=0);
          Real active_batt( start=0);
          Real p_out;
          Real p_max;
          Real batt_ctrl_filtered;
          Modelica.Blocks.Continuous.FirstOrder firstOrder_plim(
            k=1,
            T=delayP,
            initType=Modelica.Blocks.Types.Init.SteadyState,
            y_start=1) "Time delay for Plim adjustment" annotation (Placement(
                transformation(
                extent={{-10,-10},{10,10}},
                rotation=90,
                origin={-70,-70})));
          Modelica.Blocks.Continuous.FirstOrder firstOrder_q(
            k=1,
            initType=Modelica.Blocks.Types.Init.SteadyState,
            y_start=0,
            T=delayQ)  "Time delay for pf adjustment" annotation (Placement(
                transformation(
                extent={{-10,-10},{10,10}},
                rotation=90,
                origin={-10,-70})));
          Modelica.Blocks.Continuous.FirstOrder firstOrder_battctrl(
            initType=Modelica.Blocks.Types.Init.SteadyState,
            T=delaybattery,
            y_start=0,
            k=-1)      "Time delay for battery control" annotation (Placement(
                transformation(
                extent={{-10,-10},{10,10}},
                rotation=90,
                origin={60,-70})));
          Modelica.Blocks.Interfaces.RealOutput batt_ctrl_inv
            "Battery control signal to battery"
            annotation (Placement(transformation(extent={{100,-90},{120,-70}})));
          Flexgrid.Components.Inverter.Interfaces.InvCtrlBus invCtrlBus annotation (
              Placement(transformation(extent={{-10,-110},{10,-90}}),iconTransformation(
                  extent={{-10,-110},{10,-90}})));
          Modelica.Blocks.Sources.RealExpression SMax(y=Smax)
            annotation (Placement(transformation(extent={{-100,-44},{-80,-24}})));
          Modelica.Blocks.Math.Product S_max_calc
            annotation (Placement(transformation(extent={{-60,-50},{-40,-30}})));
          Modelica.Blocks.Sources.RealExpression ActivePower_Ctrl(y=p_out)
            "Controlled active power generation with constraints"
            annotation (Placement(transformation(extent={{-10,40},{-30,60}})));
          Modelica.Blocks.Math.Gain effPV(k=etaPV)
            "Efficiency of PV system (DCDC and MPPT)"
            annotation (Placement(transformation(extent={{90,50},{70,70}})));
          Modelica.Blocks.Math.Product batt_final
            annotation (Placement(transformation(extent={{70,-34},{90,-14}})));
          Modelica.Blocks.Continuous.LimPID PI_batt(
            yMin=0,
            controllerType=Modelica.Blocks.Types.SimpleController.PI,
            yMax=1) "Proportional Integral controller for battery control"
            annotation (Placement(transformation(extent={{40,-10},{60,10}})));
          Modelica.Blocks.Math.Abs abs_active "Absolute of active power generation"
            annotation (Placement(transformation(extent={{0,-22},{20,-2}})));
          Modelica.Blocks.Sources.RealExpression Battery_Ctrl(y=batt_ctrl_filtered)
            "Controlledbattery power with constraints"
            annotation (Placement(transformation(extent={{40,-40},{60,-20}})));
          Modelica.Blocks.Interfaces.RealOutput p( start=0, unit="W")
                                                                     "active power output [W]"
            annotation (Placement(transformation(extent={{-100,70},{-120,90}})));
          Modelica.Blocks.Interfaces.RealOutput q( start=0, unit="var") "reactive power output [var]"
            annotation (Placement(transformation(extent={{-100,40},{-120,60}})));
          Modelica.Blocks.Sources.RealExpression ApparentPower_Output(y=sqrt(
                sens_Inverter.S[1]^2 + sens_Inverter.S[2]^2))
            "Apparent power output at sensor"
            annotation (Placement(transformation(extent={{-40,-22},{-20,-2}})));
        equation
          q_ctrl = if (firstOrder_q.y > 0) then min(min(firstOrder_q.y, QCapmax), S_max_calc.y) else max(max(firstOrder_q.y, (-1)*QIndmax), (-1)*(S_max_calc.y));
          p_max = sqrt(S_max_calc.y^2 - q_ctrl^2);
          active_batt = smooth(0, noEvent(if (P_Batt > 0) then P_Batt*etaBatt else P_Batt*(1/etaBatt)));
          active_pv = homotopy(actual = smooth(0,if effPV.y > p_max then p_max else if effPV.y < 0 then 0 else effPV.y), simplified=effPV.y);
          batt_ctrl_filtered = homotopy(actual = smooth(0,if firstOrder_battctrl.y > p_max then p_max else if firstOrder_battctrl.y < -p_max then -p_max else firstOrder_battctrl.y), simplified=firstOrder_battctrl.y);
          p_out = active_pv + active_batt;
          connect(sens_Inverter.terminal_n, term_p)
            annotation (Line(points={{-80,20},{-80,20},{-80,0},{-100,0}},
                                                        color={0,120,120}));

          connect(firstOrder_battctrl.u, invCtrlBus.batt_ctrl) annotation (Line(points={{60,-82},
                  {50,-82},{50,-100},{36,-100},{36,-99.95},{0.05,-99.95}},
                color={0,0,127}), Text(
              string="%second",
              index=1,
              extent={{6,3},{6,3}}));
          connect(firstOrder_plim.u, invCtrlBus.plim) annotation (Line(points={{-70,-82},
                  {-60,-82},{-60,-100},{-20,-100},{-20,-99.95},{0.05,-99.95}},  color={0,
                  0,127}), Text(
              string="%second",
              index=1,
              extent={{6,3},{6,3}}));
          connect(S_max_calc.u1,SMax. y)
            annotation (Line(points={{-62,-34},{-72,-34},{-79,-34}}, color={0,0,127}));
          connect(S_max_calc.u2, firstOrder_plim.y) annotation (Line(points={{-62,-46},{
                  -70,-46},{-70,-60},{-70,-59}}, color={0,0,127}));
          connect(batt_final.y, batt_ctrl_inv) annotation (Line(points={{91,-24},{94,-24},
                  {94,-80},{110,-80}}, color={0,0,127}));
          connect(ActivePower_Ctrl.y, Load.Pow)
            annotation (Line(points={{-31,50},{-31,50},{-48,50}},color={0,0,127}));
          connect(PI_batt.y, batt_final.u1) annotation (Line(points={{61,0},{64,0},{64,-18},
                  {66,-18},{68,-18}}, color={0,0,127}));
          connect(S_max_calc.y, PI_batt.u_s) annotation (Line(points={{-39,-40},{26,-40},
                  {26,0},{38,0}}, color={0,0,127}));
          connect(abs_active.y, PI_batt.u_m)
            annotation (Line(points={{21,-12},{21,-12},{50,-12}}, color={0,0,127}));
          connect(Load.terminal, sens_Inverter.terminal_p) annotation (Line(points={{-70,50},
                  {-80,50},{-80,40}},              color={0,120,120}));
          connect(effPV.u, P_PV)
            annotation (Line(points={{92,60},{120,60},{120,60}}, color={0,0,127}));
          connect(Battery_Ctrl.y, batt_final.u2)
            annotation (Line(points={{61,-30},{68,-30}}, color={0,0,127}));
          connect(sens_Inverter.S[1], p) annotation (Line(points={{-89,24},{-94,24},{-94,
                  80},{-110,80}}, color={0,0,127}));
          connect(q, sens_Inverter.S[2]) annotation (Line(points={{-110,50},{-94,50},{-94,
                  24},{-89,24}}, color={0,0,127}));
          connect(q, invCtrlBus.q) annotation (Line(points={{-110,50},{-110,50},{-94,50},
                  {-94,-100},{20,-100},{20,-99.95},{0.05,-99.95}},            color={0,0,
                  127}), Text(
              string="%second",
              index=1,
              extent={{6,3},{6,3}}));
          connect(p, invCtrlBus.p) annotation (Line(points={{-110,80},{-94,80},{-94,-100},
                  {-36,-100},{-36,-99.95},{0.05,-99.95}},  color={0,0,127}), Text(
              string="%second",
              index=1,
              extent={{6,3},{6,3}}));
          connect(sens_Inverter.V, invCtrlBus.v) annotation (Line(points={{-89,30},{-94,
                  30},{-94,-100},{-36,-100},{-36,-99.95},{0.05,-99.95}},  color={0,0,127}),
              Text(
              string="%second",
              index=1,
              extent={{6,3},{6,3}}));
          connect(firstOrder_q.u, invCtrlBus.qctrl) annotation (Line(points={{-10,-82},{
                  -10,-82},{-10,-99.95},{0.05,-99.95}},  color={0,0,127}), Text(
              string="%second",
              index=1,
              extent={{6,3},{6,3}}));
          connect(ReactivePower_Ctrl.y, Load.Q) annotation (Line(points={{-31,70},{-40,70},
                  {-40,56},{-48,56}}, color={0,0,127}));
          connect(ApparentPower_Output.y, abs_active.u)
            annotation (Line(points={{-19,-12},{-10,-12},{-2,-12}}, color={0,0,127}));
          annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
                coordinateSystem(preserveAspectRatio=false)));
        end Inverter;

        model Inverter_prefP
          import Flexgrid = SCooDER;
          parameter Modelica.SIunits.Voltage V_nominal(min=0, start=240) = 240
            "Nominal voltage";
          parameter Real etaPV(min=0, max=1, unit="1") = 0.988*0.974
            "Conversion efficiency for PV";
          parameter Real etaBatt(min=0, max=1, unit="1") = 0.974
            "Conversion efficiency for battery";
          parameter Real delayP(unit="s") = 0.03
            "Time constant for Active Power control";
          parameter Real delayQ(unit="s") = 0.03
            "Time constant for Reactive Power control";
          parameter Real delaybattery(unit="s") = 0.03
            "Time constant for Battery control";
          parameter Real Smax(min=0, unit="VA") = 7600
            "Maximal apparent power";
          parameter Real QIndmax(min=0, unit="var") = 2500
            "Maximal reactive power (Inductive)";
          parameter Real QCapmax(min=0, unit="var") = 2500
            "Maximal reactive power (Capacitive)";

          Buildings.Electrical.AC.OnePhase.Interfaces.Terminal_n term_p
            annotation (Placement(transformation(extent={{-110,-10},{-90,10}})));
          Modelica.Blocks.Interfaces.RealInput P_PV(unit="W")
            "Power generation from PV (pos if produced)" annotation (Placement(
                transformation(
                extent={{-20,-20},{20,20}},
                rotation=180,
                origin={120,60}), iconTransformation(
                extent={{-20,-20},{20,20}},
                rotation=180,
                origin={120,60})));
          Modelica.Blocks.Interfaces.RealInput P_Batt(unit="W")
            "Power to/from Battery (pos if produced)" annotation (Placement(
                transformation(
                extent={{-20,-20},{20,20}},
                rotation=180,
                origin={120,-30}), iconTransformation(
                extent={{-20,-20},{20,20}},
                rotation=180,
                origin={120,-30})));
          Buildings.Electrical.AC.OnePhase.Sensors.GeneralizedSensor sens_Inverter
            annotation (Placement(transformation(extent={{-10,10},{10,-10}},
                rotation=90,
                origin={-80,30})));
          Flexgrid.Components.Inverter.Model.InverterLoad_PQ Load(V_nominal=120)
            "Negative (inductive/capacitive) load to simulate Inverter"
            annotation (Placement(transformation(extent={{-70,40},{-50,60}})));
          Modelica.Blocks.Sources.RealExpression ReactivePower_Ctrl(y=q_ctrl)
            "Controlled q with constraints"
            annotation (Placement(transformation(extent={{-10,60},{-30,80}})));
          Real q_ctrl;
          Real active_pv( start=0);
          Real active_batt( start=0);
          Real p_out;
          Real p_max;
          Real batt_ctrl_filtered;
          Modelica.Blocks.Continuous.FirstOrder firstOrder_plim(
            k=1,
            T=delayP,
            initType=Modelica.Blocks.Types.Init.SteadyState,
            y_start=1) "Time delay for Plim adjustment" annotation (Placement(
                transformation(
                extent={{-10,-10},{10,10}},
                rotation=90,
                origin={-70,-70})));
          Modelica.Blocks.Continuous.FirstOrder firstOrder_q(
            k=1,
            initType=Modelica.Blocks.Types.Init.SteadyState,
            y_start=0,
            T=delayQ)  "Time delay for pf adjustment" annotation (Placement(
                transformation(
                extent={{-10,-10},{10,10}},
                rotation=90,
                origin={-10,-70})));
          Modelica.Blocks.Continuous.FirstOrder firstOrder_battctrl(
            initType=Modelica.Blocks.Types.Init.SteadyState,
            T=delaybattery,
            y_start=0,
            k=-1)      "Time delay for battery control" annotation (Placement(
                transformation(
                extent={{-10,-10},{10,10}},
                rotation=90,
                origin={60,-70})));
          Modelica.Blocks.Interfaces.RealOutput batt_ctrl_inv
            "Battery control signal to battery"
            annotation (Placement(transformation(extent={{100,-90},{120,-70}})));
          Flexgrid.Components.Inverter.Interfaces.InvCtrlBus invCtrlBus annotation (
              Placement(transformation(extent={{-10,-110},{10,-90}}),iconTransformation(
                  extent={{-10,-110},{10,-90}})));
          Modelica.Blocks.Sources.RealExpression SMax(y=Smax)
            annotation (Placement(transformation(extent={{-100,-44},{-80,-24}})));
          Modelica.Blocks.Math.Product S_max_calc
            annotation (Placement(transformation(extent={{-60,-50},{-40,-30}})));
          Modelica.Blocks.Sources.RealExpression ActivePower_Ctrl(y=p_out)
            "Controlled active power generation with constraints"
            annotation (Placement(transformation(extent={{-10,40},{-30,60}})));
          Modelica.Blocks.Math.Gain effPV(k=etaPV)
            "Efficiency of PV system (DCDC and MPPT)"
            annotation (Placement(transformation(extent={{90,50},{70,70}})));
          Modelica.Blocks.Math.Product batt_final
            annotation (Placement(transformation(extent={{70,-34},{90,-14}})));
          Modelica.Blocks.Continuous.LimPID PI_batt(
            yMin=0,
            controllerType=Modelica.Blocks.Types.SimpleController.PI,
            yMax=1) "Proportional Integral controller for battery control"
            annotation (Placement(transformation(extent={{40,-10},{60,10}})));
          Modelica.Blocks.Math.Abs abs_active "Absolute of active power generation"
            annotation (Placement(transformation(extent={{0,-22},{20,-2}})));
          Modelica.Blocks.Sources.RealExpression Battery_Ctrl(y=batt_ctrl_filtered)
            "Controlledbattery power with constraints"
            annotation (Placement(transformation(extent={{40,-40},{60,-20}})));
          Modelica.Blocks.Interfaces.RealOutput p( start=0, unit="W")
                                                                     "active power output [W]"
            annotation (Placement(transformation(extent={{-100,70},{-120,90}})));
          Modelica.Blocks.Interfaces.RealOutput q( start=0, unit="var") "reactive power output [var]"
            annotation (Placement(transformation(extent={{-100,40},{-120,60}})));
          Modelica.Blocks.Sources.RealExpression ApparentPower_Output(y=sqrt(
                sens_Inverter.S[1]^2 + sens_Inverter.S[2]^2))
            "Apparent power output at sensor"
            annotation (Placement(transformation(extent={{-40,-22},{-20,-2}})));
        equation
          p_max =S_max_calc.y;
          active_batt = smooth(0, noEvent(if (P_Batt > 0) then P_Batt*etaBatt else P_Batt*(1/etaBatt)));
          active_pv = homotopy(actual = smooth(0,if effPV.y > p_max then p_max else if effPV.y < 0 then 0 else effPV.y), simplified=effPV.y);
          batt_ctrl_filtered = homotopy(actual = smooth(0,if firstOrder_battctrl.y > p_max then p_max else if firstOrder_battctrl.y < -p_max then -p_max else firstOrder_battctrl.y), simplified=firstOrder_battctrl.y);
          p_out = active_pv + active_batt;
          q_ctrl = if (firstOrder_q.y > 0) then min(min(firstOrder_q.y, QCapmax), Smax-abs(p_out)) else max(max(firstOrder_q.y, (-1)*QIndmax), (-1)*(Smax-abs(p_out)));
          connect(sens_Inverter.terminal_n, term_p)
            annotation (Line(points={{-80,20},{-80,20},{-80,0},{-100,0}},
                                                        color={0,120,120}));

          connect(firstOrder_battctrl.u, invCtrlBus.batt_ctrl) annotation (Line(points={{60,-82},
                  {50,-82},{50,-100},{36,-100},{36,-99.95},{0.05,-99.95}},
                color={0,0,127}), Text(
              string="%second",
              index=1,
              extent={{6,3},{6,3}}));
          connect(firstOrder_plim.u, invCtrlBus.plim) annotation (Line(points={{-70,-82},
                  {-60,-82},{-60,-100},{-20,-100},{-20,-99.95},{0.05,-99.95}},  color={0,
                  0,127}), Text(
              string="%second",
              index=1,
              extent={{6,3},{6,3}}));
          connect(S_max_calc.u1,SMax. y)
            annotation (Line(points={{-62,-34},{-72,-34},{-79,-34}}, color={0,0,127}));
          connect(S_max_calc.u2, firstOrder_plim.y) annotation (Line(points={{-62,-46},{
                  -70,-46},{-70,-60},{-70,-59}}, color={0,0,127}));
          connect(batt_final.y, batt_ctrl_inv) annotation (Line(points={{91,-24},{94,-24},
                  {94,-80},{110,-80}}, color={0,0,127}));
          connect(ActivePower_Ctrl.y, Load.Pow)
            annotation (Line(points={{-31,50},{-31,50},{-48,50}},color={0,0,127}));
          connect(PI_batt.y, batt_final.u1) annotation (Line(points={{61,0},{64,0},{64,-18},
                  {66,-18},{68,-18}}, color={0,0,127}));
          connect(S_max_calc.y, PI_batt.u_s) annotation (Line(points={{-39,-40},{26,-40},
                  {26,0},{38,0}}, color={0,0,127}));
          connect(abs_active.y, PI_batt.u_m)
            annotation (Line(points={{21,-12},{21,-12},{50,-12}}, color={0,0,127}));
          connect(Load.terminal, sens_Inverter.terminal_p) annotation (Line(points={{-70,50},
                  {-80,50},{-80,40}},              color={0,120,120}));
          connect(effPV.u, P_PV)
            annotation (Line(points={{92,60},{120,60},{120,60}}, color={0,0,127}));
          connect(Battery_Ctrl.y, batt_final.u2)
            annotation (Line(points={{61,-30},{68,-30}}, color={0,0,127}));
          connect(sens_Inverter.S[1], p) annotation (Line(points={{-89,24},{-94,24},{-94,
                  80},{-110,80}}, color={0,0,127}));
          connect(q, sens_Inverter.S[2]) annotation (Line(points={{-110,50},{-94,50},{-94,
                  24},{-89,24}}, color={0,0,127}));
          connect(q, invCtrlBus.q) annotation (Line(points={{-110,50},{-110,50},{-94,50},
                  {-94,-100},{20,-100},{20,-99.95},{0.05,-99.95}},            color={0,0,
                  127}), Text(
              string="%second",
              index=1,
              extent={{6,3},{6,3}}));
          connect(p, invCtrlBus.p) annotation (Line(points={{-110,80},{-94,80},{-94,-100},
                  {-36,-100},{-36,-99.95},{0.05,-99.95}},  color={0,0,127}), Text(
              string="%second",
              index=1,
              extent={{6,3},{6,3}}));
          connect(sens_Inverter.V, invCtrlBus.v) annotation (Line(points={{-89,30},{-94,
                  30},{-94,-100},{-36,-100},{-36,-99.95},{0.05,-99.95}},  color={0,0,127}),
              Text(
              string="%second",
              index=1,
              extent={{6,3},{6,3}}));
          connect(firstOrder_q.u, invCtrlBus.qctrl) annotation (Line(points={{-10,-82},{
                  -10,-82},{-10,-99.95},{0.05,-99.95}},  color={0,0,127}), Text(
              string="%second",
              index=1,
              extent={{6,3},{6,3}}));
          connect(ReactivePower_Ctrl.y, Load.Q) annotation (Line(points={{-31,70},{-40,70},
                  {-40,56},{-48,56}}, color={0,0,127}));
          connect(ApparentPower_Output.y, abs_active.u)
            annotation (Line(points={{-19,-12},{-10,-12},{-2,-12}}, color={0,0,127}));
          annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
                coordinateSystem(preserveAspectRatio=false)));
        end Inverter_prefP;

        model Inverter_pf
          import Flexgrid = SCooDER;
          parameter Modelica.SIunits.Voltage V_nominal(min=0, start=240) = 240
            "Nominal voltage (V_nominal >= 0)";
          parameter Real etaPV(min=0, max=1, unit="1") = 0.988*0.974
            "Inverter conversion efficiency";
          parameter Real etaBatt(min=0, max=1, unit="1") = 0.974
            "Inverter conversion efficiency";
          parameter Real maxIndPf(min=0.1, max=1, unit="1") = 0.8
            "Minimal Inductive power factor of inverter";
          parameter Real maxCapPf(min=0.1, max=1, unit="1") = 0.8
            "Maximal Capacitive power factor of inverter";
          parameter Real delayP(unit="s") = 0.03
            "Time constant for Active Power control";
          parameter Real delaypf(unit="s") = 0.03
            "Time constant for Power Factor control";
          parameter Real delaybattery(unit="s") = 0.03
            "Time constant for Battery control";
          parameter Real Pmax(min=0, unit="W") = 7600
            "Maximal apparent power of inverter";
          parameter Real Qmax(min=0, unit="var") = 2500
            "Maximal reactive power of inverter";

          Buildings.Electrical.AC.OnePhase.Interfaces.Terminal_n term_p
            annotation (Placement(transformation(extent={{-110,-10},{-90,10}})));
          Modelica.Blocks.Interfaces.RealInput P_PV(unit="W")
            "Power generation from PV (pos if produced)" annotation (Placement(
                transformation(
                extent={{-20,-20},{20,20}},
                rotation=180,
                origin={120,60}), iconTransformation(
                extent={{-20,-20},{20,20}},
                rotation=180,
                origin={120,60})));
          Modelica.Blocks.Interfaces.RealInput P_Batt(unit="W")
            "Power to/from Battery (pos if produced)" annotation (Placement(
                transformation(
                extent={{-20,-20},{20,20}},
                rotation=180,
                origin={120,-30}), iconTransformation(
                extent={{-20,-20},{20,20}},
                rotation=180,
                origin={120,-30})));
          Buildings.Electrical.AC.OnePhase.Sensors.GeneralizedSensor sens_Inverter
            annotation (Placement(transformation(extent={{-10,10},{10,-10}},
                rotation=90,
                origin={-80,30})));
          Flexgrid.Components.Inverter.Model.InverterLoad_pf Load(V_nominal=120)
            "Negative (inductive/capacitive) load to simulate Inverter"
            annotation (Placement(transformation(extent={{-70,40},{-50,60}})));
          Modelica.Blocks.Sources.RealExpression PF_Ctrl(y=pf_ctrl)
            "Controlled pf with constraints"
            annotation (Placement(transformation(extent={{-10,60},{-30,80}})));
          Real pf_ctrl;
          //Real pf_temp;
          Real max_pf;
          Real active_pv( start=0);
          Real active_batt( start=0);
          Real p_out;
          Real p_max;
          Real batt_ctrl_filtered;
          Modelica.Blocks.Continuous.FirstOrder firstOrder_plim(
            k=1,
            T=delayP,
            initType=Modelica.Blocks.Types.Init.SteadyState,
            y_start=1) "Time delay for Plim adjustment" annotation (Placement(
                transformation(
                extent={{-10,-10},{10,10}},
                rotation=90,
                origin={-70,-70})));
          Modelica.Blocks.Continuous.FirstOrder firstOrder_pf(
            k=1,
            initType=Modelica.Blocks.Types.Init.SteadyState,
            y_start=1,
            T=delaypf) "Time delay for pf adjustment" annotation (Placement(
                transformation(
                extent={{-10,-10},{10,10}},
                rotation=90,
                origin={-10,-70})));
          Modelica.Blocks.Continuous.FirstOrder firstOrder_battctrl(
            k=1,
            initType=Modelica.Blocks.Types.Init.SteadyState,
            T=delaybattery,
            y_start=0) "Time delay for battery control" annotation (Placement(
                transformation(
                extent={{-10,-10},{10,10}},
                rotation=90,
                origin={60,-70})));
          Modelica.Blocks.Interfaces.RealOutput batt_ctrl_inv
            "Battery control signal to battery"
            annotation (Placement(transformation(extent={{100,-90},{120,-70}})));
          Flexgrid.Components.Inverter.Interfaces.InvCtrlBus invCtrlBus annotation (
              Placement(transformation(extent={{10,-110},{30,-90}}), iconTransformation(
                  extent={{10,-110},{30,-90}})));
          Modelica.Blocks.Sources.RealExpression PMax(y=Pmax)
            annotation (Placement(transformation(extent={{-100,-44},{-80,-24}})));
          Modelica.Blocks.Math.Product P_max_calc
            annotation (Placement(transformation(extent={{-60,-50},{-40,-30}})));
          Modelica.Blocks.Sources.RealExpression ActivePower_Ctrl(y=p_out)
            "Controlled active power generation with constraints"
            annotation (Placement(transformation(extent={{-10,40},{-30,60}})));
          Modelica.Blocks.Math.Gain effPV(k=etaPV)
            "Efficiency of PV system (DCDC and MPPT)"
            annotation (Placement(transformation(extent={{90,50},{70,70}})));
          Modelica.Blocks.Math.Product batt_final
            annotation (Placement(transformation(extent={{70,-34},{90,-14}})));
          Modelica.Blocks.Continuous.LimPID PI_batt(
            yMin=0,
            controllerType=Modelica.Blocks.Types.SimpleController.PI,
            yMax=1) "Proportional Integral controller for battery control"
            annotation (Placement(transformation(extent={{40,-10},{60,10}})));
          Modelica.Blocks.Math.Abs abs_active "Absolute of active power generation"
            annotation (Placement(transformation(extent={{0,-22},{20,-2}})));
          Modelica.Blocks.Sources.RealExpression Battery_Ctrl(y=batt_ctrl_filtered)
            "Controlledbattery power with constraints"
            annotation (Placement(transformation(extent={{40,-40},{60,-20}})));
          Modelica.Blocks.Interfaces.RealOutput p( start=0, unit="W")
                                                                     "active power output [W]"
            annotation (Placement(transformation(extent={{-100,70},{-120,90}})));
          Modelica.Blocks.Interfaces.RealOutput q( start=0, unit="var") "reactive power output [var]"
            annotation (Placement(transformation(extent={{-100,40},{-120,60}})));
        equation
          p_max = P_max_calc.y;
          active_batt = smooth(0, noEvent(if (P_Batt > 0) then P_Batt*etaBatt else P_Batt*(1/etaBatt)));
          active_pv = homotopy(actual = smooth(0,if effPV.y > p_max then p_max else if effPV.y < 0 then 0 else effPV.y), simplified=effPV.y);
          batt_ctrl_filtered = homotopy(actual = smooth(0,if firstOrder_battctrl.y > p_max then p_max else if firstOrder_battctrl.y < -p_max then -p_max else firstOrder_battctrl.y), simplified=firstOrder_battctrl.y);
         // p_out = (-1)*(active_pv + active_batt);
          p_out = active_pv + active_batt;
          max_pf = sqrt(p_out^2/(p_out^2+Qmax^2));
          pf_ctrl = if (firstOrder_pf.u > 0) then max(max(firstOrder_pf.y, maxIndPf), max_pf) else min(min(firstOrder_pf.y, (-1)*maxCapPf), (-1)*max_pf);
          //pf_ctrl = if (p_out > 10 or p_out < -10) then pf_temp else 1;
          connect(sens_Inverter.terminal_n, term_p)
            annotation (Line(points={{-80,20},{-80,20},{-80,0},{-100,0}},
                                                        color={0,120,120}));

          connect(firstOrder_battctrl.u, invCtrlBus.batt_ctrl) annotation (Line(points={
                  {60,-82},{50,-82},{50,-100},{36,-100},{36,-99.95},{20.05,-99.95}},
                color={0,0,127}), Text(
              string="%second",
              index=1,
              extent={{6,3},{6,3}}));
          connect(firstOrder_pf.u, invCtrlBus.pf) annotation (Line(points={{-10,-82},{0,
                  -82},{0,-100},{20,-100}},        color={0,0,127}), Text(
              string="%second",
              index=1,
              extent={{6,3},{6,3}}));
          connect(firstOrder_plim.u, invCtrlBus.plim) annotation (Line(points={{-70,-82},
                  {-60,-82},{-60,-100},{-20,-100},{-20,-99.95},{20.05,-99.95}}, color={0,
                  0,127}), Text(
              string="%second",
              index=1,
              extent={{6,3},{6,3}}));
          connect(P_max_calc.u1, PMax.y)
            annotation (Line(points={{-62,-34},{-72,-34},{-79,-34}}, color={0,0,127}));
          connect(P_max_calc.u2, firstOrder_plim.y) annotation (Line(points={{-62,-46},{
                  -70,-46},{-70,-60},{-70,-59}}, color={0,0,127}));
          connect(batt_final.y, batt_ctrl_inv) annotation (Line(points={{91,-24},{94,-24},
                  {94,-80},{110,-80}}, color={0,0,127}));
          connect(ActivePower_Ctrl.y, Load.Pow)
            annotation (Line(points={{-31,50},{-31,50},{-48,50}},color={0,0,127}));
          connect(PI_batt.y, batt_final.u1) annotation (Line(points={{61,0},{64,0},{64,-18},
                  {66,-18},{68,-18}}, color={0,0,127}));
          connect(P_max_calc.y, PI_batt.u_s) annotation (Line(points={{-39,-40},{26,-40},
                  {26,0},{38,0}}, color={0,0,127}));
          connect(abs_active.y, PI_batt.u_m)
            annotation (Line(points={{21,-12},{21,-12},{50,-12}}, color={0,0,127}));
          connect(Load.terminal, sens_Inverter.terminal_p) annotation (Line(points={{-70,50},
                  {-80,50},{-80,40}},              color={0,120,120}));
          connect(effPV.u, P_PV)
            annotation (Line(points={{92,60},{120,60},{120,60}}, color={0,0,127}));
          connect(Battery_Ctrl.y, batt_final.u2)
            annotation (Line(points={{61,-30},{68,-30}}, color={0,0,127}));
          connect(abs_active.u, ActivePower_Ctrl.y) annotation (Line(points={{-2,-12},{
                  -40,-12},{-40,50},{-31,50}}, color={0,0,127}));
          connect(PF_Ctrl.y, Load.pf_in) annotation (Line(points={{-31,70},{-40,70},{
                  -40,56},{-48,56}}, color={0,0,127}));
          connect(sens_Inverter.S[1], p) annotation (Line(points={{-89,24},{-94,24},{-94,
                  80},{-110,80}}, color={0,0,127}));
          connect(q, sens_Inverter.S[2]) annotation (Line(points={{-110,50},{-94,50},{-94,
                  24},{-89,24}}, color={0,0,127}));
          connect(q, invCtrlBus.q) annotation (Line(points={{-110,50},{-110,50},{-94,50},
                  {-94,-100},{20,-100},{20,-100},{20,-99.95},{20.05,-99.95}}, color={0,0,
                  127}), Text(
              string="%second",
              index=1,
              extent={{6,3},{6,3}}));
          connect(p, invCtrlBus.p) annotation (Line(points={{-110,80},{-94,80},{-94,-100},
                  {-36,-100},{-36,-99.95},{20.05,-99.95}}, color={0,0,127}), Text(
              string="%second",
              index=1,
              extent={{6,3},{6,3}}));
          connect(sens_Inverter.V, invCtrlBus.v) annotation (Line(points={{-89,30},{-94,
                  30},{-94,-100},{-36,-100},{-36,-99.95},{20.05,-99.95}}, color={0,0,127}),
              Text(
              string="%second",
              index=1,
              extent={{6,3},{6,3}}));
          annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
                coordinateSystem(preserveAspectRatio=false)));
        end Inverter_pf;

        model InverterLoad_pf
          "Model of Inverter as incuctive and resistive load with pf -1 to 1"
          extends .SCooDER.Components.Inverter.Interfaces.Load_partial(
            redeclare package PhaseSystem =
                Buildings.Electrical.PhaseSystems.OnePhase,
            redeclare Buildings.Electrical.AC.OnePhase.Interfaces.Terminal_n
              terminal,
            V_nominal(start=120));

          Modelica.Blocks.Interfaces.RealInput pf_in(unit="1") "Power factor" annotation (Placement(transformation(
                extent={{-20,-20},{20,20}},
                rotation=180,
                origin={120,60}),  iconTransformation(
                extent={{-20,-20},{20,20}},
                rotation=180,
                origin={120,60})));
        protected
          Modelica.Blocks.Interfaces.RealInput pf_internal
            "Hidden value of the input load for the conditional connector";
          Modelica.SIunits.Power Q = P*tan(-acos(pf_internal))
            "Reactive power";
        equation
          connect(pf_in, pf_internal);

          i[1] = -homotopy(actual = (v[2]*Q + v[1]*P)/(v[1]^2 + v[2]^2), simplified= 0.0);
          i[2] = -homotopy(actual = (v[2]*P - v[1]*Q)/(v[1]^2 + v[2]^2), simplified= 0.0);

          annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
                coordinateSystem(preserveAspectRatio=false)));
        end InverterLoad_pf;

        model InverterLoad_PQ
          parameter Real V_start(start=120) = 120;
          extends .SCooDER.Components.Inverter.Interfaces.Load_partial(
            redeclare package PhaseSystem =
                Buildings.Electrical.PhaseSystems.OnePhase,
            redeclare Buildings.Electrical.AC.OnePhase.Interfaces.Terminal_n
              terminal,
            V_nominal=V_start);
          Modelica.Blocks.Interfaces.RealInput Q(unit="var") "Reactive Power Input"
            annotation (Placement(transformation(
                extent={{-20,-20},{20,20}},
                rotation=180,
                origin={120,60}), iconTransformation(
                extent={{-20,-20},{20,20}},
                rotation=180,
                origin={120,60})));
        equation
          i[1] = -homotopy(actual = (v[2]*Q + v[1]*P)/(v[1]^2 + v[2]^2), simplified= 0.0);
          i[2] = -homotopy(actual = (v[2]*P - v[1]*Q)/(v[1]^2 + v[2]^2), simplified= 0.0);

          annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
                coordinateSystem(preserveAspectRatio=false)));
        end InverterLoad_PQ;

        model SpotLoad_Y_PQ
          parameter Modelica.SIunits.ActivePower P1(start=0) "Positive = load; Negative = source";
          parameter Modelica.SIunits.ReactivePower Q1(start=0) "Positive = capacitive; Negative = inductive";
          parameter Modelica.SIunits.ActivePower P2(start=0) "Positive = load; Negative = source";
          parameter Modelica.SIunits.ReactivePower Q2(start=0) "Positive = capacitive; Negative = inductive";
          parameter Modelica.SIunits.ActivePower P3(start=0) "Positive = load; Negative = source";
          parameter Modelica.SIunits.ReactivePower Q3(start=0) "Positive = capacitive; Negative = inductive";
          parameter Modelica.SIunits.Voltage V_start=120;

          Buildings.Electrical.AC.ThreePhasesUnbalanced.Interfaces.Terminal_n
            terminal_n
            annotation (Placement(transformation(extent={{90,-10},{110,10}}), iconTransformation(extent={{90,-10},{110,10}})));
          Buildings.Electrical.AC.ThreePhasesUnbalanced.Interfaces.WyeToWyeGround
            wyeToWyeGround "Wye to wye grounded connection"
            annotation (Placement(transformation(extent={{80,-10},{60,10}})));
        protected
          Buildings.Electrical.AC.ThreePhasesUnbalanced.Interfaces.Adapter3to3 ada "Adapter"
            annotation (Placement(transformation(extent={{32,-10},{52,10}})));
        public
          InverterLoad_PQ PQ1(V_start=V_start, V_nominal=V_start)
            annotation (Placement(transformation(extent={{0,30},{-20,50}})));
          InverterLoad_PQ PQ3(V_start=V_start, V_nominal=V_start)
            annotation (Placement(transformation(extent={{0,-50},{-20,-30}})));
          InverterLoad_PQ PQ2(V_start=V_start, V_nominal=V_start)
            annotation (Placement(transformation(extent={{0,-10},{-20,10}})));
          Modelica.Blocks.Sources.RealExpression PQ1_Q(y=Q1)
            annotation (Placement(transformation(extent={{-80,36},{-60,56}})));
          Modelica.Blocks.Sources.RealExpression PQ1_P(y=-P1)
            annotation (Placement(transformation(extent={{-80,22},{-60,42}})));
          Modelica.Blocks.Sources.RealExpression PQ2_Q(y=Q2)
            annotation (Placement(transformation(extent={{-80,-4},{-60,16}})));
          Modelica.Blocks.Sources.RealExpression PQ2_P(y=-P2)
            annotation (Placement(transformation(extent={{-80,-18},{-60,2}})));
          Modelica.Blocks.Sources.RealExpression PQ3_Q(y=Q3)
            annotation (Placement(transformation(extent={{-80,-44},{-60,-24}})));
          Modelica.Blocks.Sources.RealExpression PQ3_P(y=-P3)
            annotation (Placement(transformation(extent={{-80,-58},{-60,-38}})));
        equation
          connect(ada.terminal, wyeToWyeGround.wyeg)
            annotation (Line(points={{52,0},{56,0},{60,0}}, color={0,120,120}));
          connect(wyeToWyeGround.wye, terminal_n)
            annotation (Line(points={{80,0},{100,0},{100,0}}, color={0,120,120}));
          connect(PQ1.terminal, ada.terminals[1]) annotation (Line(points={{0,40},{20,40},
                  {20,0.533333},{32.2,0.533333}}, color={0,120,120}));
          connect(PQ2.terminal, ada.terminals[2])
            annotation (Line(points={{0,0},{32.2,0}}, color={0,120,120}));
          connect(PQ3.terminal, ada.terminals[3]) annotation (Line(points={{0,-40},{20,-40},
                  {20,-0.533333},{32.2,-0.533333}}, color={0,120,120}));
          connect(PQ1_P.y, PQ1.Pow) annotation (Line(points={{-59,32},{-60,32},{-56,32},
                  {-40,32},{-40,40},{-22,40}}, color={0,0,127}));
          connect(PQ1_Q.y, PQ1.Q)
            annotation (Line(points={{-59,46},{-40,46},{-22,46}}, color={0,0,127}));
          connect(PQ2_Q.y, PQ2.Q)
            annotation (Line(points={{-59,6},{-40,6},{-22,6}}, color={0,0,127}));
          connect(PQ2_P.y, PQ2.Pow) annotation (Line(points={{-59,-8},{-40,-8},{-40,0},{
                  -22,0}}, color={0,0,127}));
          connect(PQ3_Q.y, PQ3.Q)
            annotation (Line(points={{-59,-34},{-42,-34},{-22,-34}}, color={0,0,127}));
          connect(PQ3_P.y, PQ3.Pow) annotation (Line(points={{-59,-48},{-40,-48},{-40,-40},
                  {-22,-40}}, color={0,0,127}));
          annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
                coordinateSystem(preserveAspectRatio=false)));
        end SpotLoad_Y_PQ;

        model SpotLoad_D_PQ
          parameter Modelica.SIunits.ActivePower P1(start=0) "Positive = load; Negative = source";
          parameter Modelica.SIunits.ReactivePower Q1(start=0) "Positive = capacitive; Negative = inductive";
          parameter Modelica.SIunits.ActivePower P2(start=0) "Positive = load; Negative = source";
          parameter Modelica.SIunits.ReactivePower Q2(start=0) "Positive = capacitive; Negative = inductive";
          parameter Modelica.SIunits.ActivePower P3(start=0) "Positive = load; Negative = source";
          parameter Modelica.SIunits.ReactivePower Q3(start=0) "Positive = capacitive; Negative = inductive";
          parameter Modelica.SIunits.Voltage V_start=120;

          Buildings.Electrical.AC.ThreePhasesUnbalanced.Interfaces.Terminal_n
            terminal_n
            annotation (Placement(transformation(extent={{90,-10},{110,10}}), iconTransformation(extent={{90,-10},{110,10}})));
          Buildings.Electrical.AC.ThreePhasesUnbalanced.Interfaces.WyeToDelta
            wyeToWyeGround "Wye to wye grounded connection"
            annotation (Placement(transformation(extent={{80,-10},{60,10}})));
        protected
          Buildings.Electrical.AC.ThreePhasesUnbalanced.Interfaces.Adapter3to3 ada "Adapter"
            annotation (Placement(transformation(extent={{32,-10},{52,10}})));
        public
          InverterLoad_PQ PQ1(V_start=V_start, V_nominal=V_start)
            annotation (Placement(transformation(extent={{0,30},{-20,50}})));
          InverterLoad_PQ PQ3(V_start=V_start, V_nominal=V_start)
            annotation (Placement(transformation(extent={{0,-50},{-20,-30}})));
          InverterLoad_PQ PQ2(V_start=V_start, V_nominal=V_start)
            annotation (Placement(transformation(extent={{0,-10},{-20,10}})));
          Modelica.Blocks.Sources.RealExpression PQ1_Q(y=Q1)
            annotation (Placement(transformation(extent={{-80,36},{-60,56}})));
          Modelica.Blocks.Sources.RealExpression PQ1_P(y=-P1)
            annotation (Placement(transformation(extent={{-80,22},{-60,42}})));
          Modelica.Blocks.Sources.RealExpression PQ2_Q(y=Q2)
            annotation (Placement(transformation(extent={{-80,-4},{-60,16}})));
          Modelica.Blocks.Sources.RealExpression PQ2_P(y=-P2)
            annotation (Placement(transformation(extent={{-80,-18},{-60,2}})));
          Modelica.Blocks.Sources.RealExpression PQ3_Q(y=Q3)
            annotation (Placement(transformation(extent={{-80,-44},{-60,-24}})));
          Modelica.Blocks.Sources.RealExpression PQ3_P(y=-P3)
            annotation (Placement(transformation(extent={{-80,-58},{-60,-38}})));
        equation
          connect(wyeToWyeGround.wye, terminal_n)
            annotation (Line(points={{80,0},{100,0}},         color={0,120,120}));
          connect(PQ1.terminal, ada.terminals[1]) annotation (Line(points={{0,40},{20,40},
                  {20,0.533333},{32.2,0.533333}}, color={0,120,120}));
          connect(PQ2.terminal, ada.terminals[2])
            annotation (Line(points={{0,0},{32.2,0}}, color={0,120,120}));
          connect(PQ3.terminal, ada.terminals[3]) annotation (Line(points={{0,-40},{20,-40},
                  {20,-0.533333},{32.2,-0.533333}}, color={0,120,120}));
          connect(PQ1_P.y,PQ1. Pow) annotation (Line(points={{-59,32},{-60,32},{-56,32},
                  {-40,32},{-40,40},{-22,40}}, color={0,0,127}));
          connect(PQ1_Q.y,PQ1. Q)
            annotation (Line(points={{-59,46},{-40,46},{-22,46}}, color={0,0,127}));
          connect(PQ2_Q.y,PQ2. Q)
            annotation (Line(points={{-59,6},{-40,6},{-22,6}}, color={0,0,127}));
          connect(PQ2_P.y,PQ2. Pow) annotation (Line(points={{-59,-8},{-40,-8},{-40,0},{
                  -22,0}}, color={0,0,127}));
          connect(PQ3_Q.y,PQ3. Q)
            annotation (Line(points={{-59,-34},{-42,-34},{-22,-34}}, color={0,0,127}));
          connect(PQ3_P.y,PQ3. Pow) annotation (Line(points={{-59,-48},{-40,-48},{-40,-40},
                  {-22,-40}}, color={0,0,127}));
          connect(ada.terminal, wyeToWyeGround.delta)
            annotation (Line(points={{52,0},{56,0},{60,0}}, color={0,120,120}));
          annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
                coordinateSystem(preserveAspectRatio=false)));
        end SpotLoad_D_PQ;

        model SpotLoad_Y_PQ_ext
          /*parameter Modelica.SIunits.ActivePower P1(start=0) "Positive = load; Negative = source";
  parameter Modelica.SIunits.ReactivePower Q1(start=0) "Positive = capacitive; Negative = inductive";
  parameter Modelica.SIunits.ActivePower P2(start=0) "Positive = load; Negative = source";
  parameter Modelica.SIunits.ReactivePower Q2(start=0) "Positive = capacitive; Negative = inductive";
  parameter Modelica.SIunits.ActivePower P3(start=0) "Positive = load; Negative = source";
  parameter Modelica.SIunits.ReactivePower Q3(start=0) "Positive = capacitive; Negative = inductive";*/
          parameter Modelica.SIunits.Voltage V_start=120;

          Buildings.Electrical.AC.ThreePhasesUnbalanced.Interfaces.Terminal_n
            terminal_n
            annotation (Placement(transformation(extent={{90,-10},{110,10}}), iconTransformation(extent={{90,-10},{110,10}})));
          Buildings.Electrical.AC.ThreePhasesUnbalanced.Interfaces.WyeToWyeGround
            wyeToWyeGround "Wye to wye grounded connection"
            annotation (Placement(transformation(extent={{80,-10},{60,10}})));
        protected
          Buildings.Electrical.AC.ThreePhasesUnbalanced.Interfaces.Adapter3to3 ada "Adapter"
            annotation (Placement(transformation(extent={{32,-10},{52,10}})));
        public
          InverterLoad_PQ PQ1(V_start=V_start, V_nominal=V_start)
            annotation (Placement(transformation(extent={{0,30},{-20,50}})));
          InverterLoad_PQ PQ3(V_start=V_start, V_nominal=V_start)
            annotation (Placement(transformation(extent={{0,-50},{-20,-30}})));
          InverterLoad_PQ PQ2(V_start=V_start, V_nominal=V_start)
            annotation (Placement(transformation(extent={{0,-10},{-20,10}})));
          Modelica.Blocks.Interfaces.RealInput P1(start=0, unit="W") "Positive = load; Negative = source" annotation (
              Placement(transformation(
                extent={{20,-20},{-20,20}},
                rotation=180,
                origin={-120,80}), iconTransformation(
                extent={{10,-10},{-10,10}},
                rotation=180,
                origin={-110,80})));
          Modelica.Blocks.Interfaces.RealInput Q1(start=0, unit="var") "Positive = capacitive; Negative = inductive" annotation (
              Placement(transformation(
                extent={{20,-20},{-20,20}},
                rotation=180,
                origin={-120,50}), iconTransformation(
                extent={{10,-10},{-10,10}},
                rotation=180,
                origin={-110,50})));
          Modelica.Blocks.Interfaces.RealInput P2(start=0, unit="W") "Positive = load; Negative = source" annotation (
              Placement(transformation(
                extent={{20,-20},{-20,20}},
                rotation=180,
                origin={-120,10}), iconTransformation(
                extent={{10,-10},{-10,10}},
                rotation=180,
                origin={-110,10})));
          Modelica.Blocks.Interfaces.RealInput Q2(start=0, unit="var") "Positive = capacitive; Negative = inductive" annotation (
              Placement(transformation(
                extent={{20,-20},{-20,20}},
                rotation=180,
                origin={-120,-20}),iconTransformation(
                extent={{10,-10},{-10,10}},
                rotation=180,
                origin={-110,-20})));
          Modelica.Blocks.Interfaces.RealInput P3(start=0, unit="W") "Positive = load; Negative = source" annotation (
              Placement(transformation(
                extent={{20,-20},{-20,20}},
                rotation=180,
                origin={-120,-60}),iconTransformation(
                extent={{10,-10},{-10,10}},
                rotation=180,
                origin={-110,-60})));
          Modelica.Blocks.Interfaces.RealInput Q3(start=0, unit="var") "Positive = capacitive; Negative = inductive" annotation (
              Placement(transformation(
                extent={{20,-20},{-20,20}},
                rotation=180,
                origin={-120,-90}),iconTransformation(
                extent={{10,-10},{-10,10}},
                rotation=180,
                origin={-110,-90})));
          Modelica.Blocks.Sources.RealExpression PQ1_Q(y=Q1)
            annotation (Placement(transformation(extent={{-80,36},{-60,56}})));
          Modelica.Blocks.Sources.RealExpression PQ1_P(y=-P1)
            annotation (Placement(transformation(extent={{-80,22},{-60,42}})));
          Modelica.Blocks.Sources.RealExpression PQ2_Q(y=Q2)
            annotation (Placement(transformation(extent={{-80,-4},{-60,16}})));
          Modelica.Blocks.Sources.RealExpression PQ2_P(y=-P2)
            annotation (Placement(transformation(extent={{-80,-18},{-60,2}})));
          Modelica.Blocks.Sources.RealExpression PQ3_Q(y=Q3)
            annotation (Placement(transformation(extent={{-80,-44},{-60,-24}})));
          Modelica.Blocks.Sources.RealExpression PQ3_P(y=-P3)
            annotation (Placement(transformation(extent={{-80,-58},{-60,-38}})));
        equation
          connect(ada.terminal, wyeToWyeGround.wyeg)
            annotation (Line(points={{52,0},{56,0},{60,0}}, color={0,120,120}));
          connect(wyeToWyeGround.wye, terminal_n)
            annotation (Line(points={{80,0},{100,0},{100,0}}, color={0,120,120}));
          connect(PQ1.terminal, ada.terminals[1]) annotation (Line(points={{0,40},{20,40},
                  {20,0.533333},{32.2,0.533333}}, color={0,120,120}));
          connect(PQ2.terminal, ada.terminals[2])
            annotation (Line(points={{0,0},{32.2,0}}, color={0,120,120}));
          connect(PQ3.terminal, ada.terminals[3]) annotation (Line(points={{0,-40},{20,-40},
                  {20,-0.533333},{32.2,-0.533333}}, color={0,120,120}));
          connect(PQ1_P.y, PQ1.Pow) annotation (Line(points={{-59,32},{-60,32},{-56,32},
                  {-40,32},{-40,40},{-22,40}}, color={0,0,127}));
          connect(PQ1_Q.y, PQ1.Q)
            annotation (Line(points={{-59,46},{-40,46},{-22,46}}, color={0,0,127}));
          connect(PQ2_Q.y, PQ2.Q)
            annotation (Line(points={{-59,6},{-40,6},{-22,6}}, color={0,0,127}));
          connect(PQ2_P.y, PQ2.Pow) annotation (Line(points={{-59,-8},{-40,-8},{-40,0},{
                  -22,0}}, color={0,0,127}));
          connect(PQ3_Q.y, PQ3.Q)
            annotation (Line(points={{-59,-34},{-42,-34},{-22,-34}}, color={0,0,127}));
          connect(PQ3_P.y, PQ3.Pow) annotation (Line(points={{-59,-48},{-40,-48},{-40,-40},
                  {-22,-40}}, color={0,0,127}));
          annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
                coordinateSystem(preserveAspectRatio=false)));
        end SpotLoad_Y_PQ_ext;

        model SpotLoad_D_PQ_ext
          /*parameter Modelica.SIunits.ActivePower P1(start=0) "Positive = load; Negative = source";
  parameter Modelica.SIunits.ReactivePower Q1(start=0) "Positive = capacitive; Negative = inductive";
  parameter Modelica.SIunits.ActivePower P2(start=0) "Positive = load; Negative = source";
  parameter Modelica.SIunits.ReactivePower Q2(start=0) "Positive = capacitive; Negative = inductive";
  parameter Modelica.SIunits.ActivePower P3(start=0) "Positive = load; Negative = source";
  parameter Modelica.SIunits.ReactivePower Q3(start=0) "Positive = capacitive; Negative = inductive";*/
          parameter Modelica.SIunits.Voltage V_start=120;

          Buildings.Electrical.AC.ThreePhasesUnbalanced.Interfaces.Terminal_n
            terminal_n
            annotation (Placement(transformation(extent={{90,-10},{110,10}}), iconTransformation(extent={{90,-10},{110,10}})));
          Buildings.Electrical.AC.ThreePhasesUnbalanced.Interfaces.WyeToDelta
            wyeToWyeGround "Wye to wye grounded connection"
            annotation (Placement(transformation(extent={{80,-10},{60,10}})));
        protected
          Buildings.Electrical.AC.ThreePhasesUnbalanced.Interfaces.Adapter3to3 ada "Adapter"
            annotation (Placement(transformation(extent={{32,-10},{52,10}})));
        public
          InverterLoad_PQ PQ1(V_start=V_start, V_nominal=V_start)
            annotation (Placement(transformation(extent={{0,30},{-20,50}})));
          InverterLoad_PQ PQ3(V_start=V_start, V_nominal=V_start)
            annotation (Placement(transformation(extent={{0,-50},{-20,-30}})));
          InverterLoad_PQ PQ2(V_start=V_start, V_nominal=V_start)
            annotation (Placement(transformation(extent={{0,-10},{-20,10}})));
          Modelica.Blocks.Sources.RealExpression PQ1_Q(y=Q1)
            annotation (Placement(transformation(extent={{-80,36},{-60,56}})));
          Modelica.Blocks.Sources.RealExpression PQ1_P(y=-P1)
            annotation (Placement(transformation(extent={{-80,22},{-60,42}})));
          Modelica.Blocks.Sources.RealExpression PQ2_Q(y=Q2)
            annotation (Placement(transformation(extent={{-80,-4},{-60,16}})));
          Modelica.Blocks.Sources.RealExpression PQ2_P(y=-P2)
            annotation (Placement(transformation(extent={{-80,-18},{-60,2}})));
          Modelica.Blocks.Sources.RealExpression PQ3_Q(y=Q3)
            annotation (Placement(transformation(extent={{-80,-44},{-60,-24}})));
          Modelica.Blocks.Sources.RealExpression PQ3_P(y=-P3)
            annotation (Placement(transformation(extent={{-80,-58},{-60,-38}})));
          Modelica.Blocks.Interfaces.RealInput P1(start=0, unit="W") "Positive = load; Negative = source" annotation (
              Placement(transformation(
                extent={{20,-20},{-20,20}},
                rotation=180,
                origin={-120,80}), iconTransformation(
                extent={{10,-10},{-10,10}},
                rotation=180,
                origin={-110,80})));
          Modelica.Blocks.Interfaces.RealInput Q1(start=0, unit="var") "Positive = capacitive; Negative = inductive" annotation (
              Placement(transformation(
                extent={{20,-20},{-20,20}},
                rotation=180,
                origin={-120,50}), iconTransformation(
                extent={{10,-10},{-10,10}},
                rotation=180,
                origin={-110,50})));
          Modelica.Blocks.Interfaces.RealInput P2(start=0, unit="W") "Positive = load; Negative = source" annotation (
              Placement(transformation(
                extent={{20,-20},{-20,20}},
                rotation=180,
                origin={-120,10}), iconTransformation(
                extent={{10,-10},{-10,10}},
                rotation=180,
                origin={-110,10})));
          Modelica.Blocks.Interfaces.RealInput Q2(start=0, unit="var") "Positive = capacitive; Negative = inductive" annotation (
              Placement(transformation(
                extent={{20,-20},{-20,20}},
                rotation=180,
                origin={-120,-20}),iconTransformation(
                extent={{10,-10},{-10,10}},
                rotation=180,
                origin={-110,-20})));
          Modelica.Blocks.Interfaces.RealInput P3(start=0, unit="W") "Positive = load; Negative = source" annotation (
              Placement(transformation(
                extent={{20,-20},{-20,20}},
                rotation=180,
                origin={-120,-60}),iconTransformation(
                extent={{10,-10},{-10,10}},
                rotation=180,
                origin={-110,-60})));
          Modelica.Blocks.Interfaces.RealInput Q3(start=0, unit="var") "Positive = capacitive; Negative = inductive" annotation (
              Placement(transformation(
                extent={{20,-20},{-20,20}},
                rotation=180,
                origin={-120,-90}),iconTransformation(
                extent={{10,-10},{-10,10}},
                rotation=180,
                origin={-110,-90})));
        equation
          connect(wyeToWyeGround.wye, terminal_n)
            annotation (Line(points={{80,0},{100,0}},         color={0,120,120}));
          connect(PQ1.terminal, ada.terminals[1]) annotation (Line(points={{0,40},{20,40},
                  {20,0.533333},{32.2,0.533333}}, color={0,120,120}));
          connect(PQ2.terminal, ada.terminals[2])
            annotation (Line(points={{0,0},{32.2,0}}, color={0,120,120}));
          connect(PQ3.terminal, ada.terminals[3]) annotation (Line(points={{0,-40},{20,-40},
                  {20,-0.533333},{32.2,-0.533333}}, color={0,120,120}));
          connect(PQ1_P.y,PQ1. Pow) annotation (Line(points={{-59,32},{-60,32},{-56,32},
                  {-40,32},{-40,40},{-22,40}}, color={0,0,127}));
          connect(PQ1_Q.y,PQ1. Q)
            annotation (Line(points={{-59,46},{-40,46},{-22,46}}, color={0,0,127}));
          connect(PQ2_Q.y,PQ2. Q)
            annotation (Line(points={{-59,6},{-40,6},{-22,6}}, color={0,0,127}));
          connect(PQ2_P.y,PQ2. Pow) annotation (Line(points={{-59,-8},{-40,-8},{-40,0},{
                  -22,0}}, color={0,0,127}));
          connect(PQ3_Q.y,PQ3. Q)
            annotation (Line(points={{-59,-34},{-42,-34},{-22,-34}}, color={0,0,127}));
          connect(PQ3_P.y,PQ3. Pow) annotation (Line(points={{-59,-48},{-40,-48},{-40,-40},
                  {-22,-40}}, color={0,0,127}));
          connect(ada.terminal, wyeToWyeGround.delta)
            annotation (Line(points={{52,0},{56,0},{60,0}}, color={0,120,120}));
          annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
                coordinateSystem(preserveAspectRatio=false)));
        end SpotLoad_D_PQ_ext;

        model SpotLoad_Y_PQ_extBus
          /*parameter Modelica.SIunits.ActivePower P1(start=0) "Positive = load; Negative = source";
  parameter Modelica.SIunits.ReactivePower Q1(start=0) "Positive = capacitive; Negative = inductive";
  parameter Modelica.SIunits.ActivePower P2(start=0) "Positive = load; Negative = source";
  parameter Modelica.SIunits.ReactivePower Q2(start=0) "Positive = capacitive; Negative = inductive";
  parameter Modelica.SIunits.ActivePower P3(start=0) "Positive = load; Negative = source";
  parameter Modelica.SIunits.ReactivePower Q3(start=0) "Positive = capacitive; Negative = inductive";*/
          parameter Modelica.SIunits.Voltage V_start=120;
          parameter Real T_const(unit="s")=0.01 "Time constant for firstorder";

          Buildings.Electrical.AC.ThreePhasesUnbalanced.Interfaces.Terminal_n
            terminal_n
            annotation (Placement(transformation(extent={{90,-10},{110,10}}), iconTransformation(extent={{90,-10},{110,10}})));
          Buildings.Electrical.AC.ThreePhasesUnbalanced.Interfaces.WyeToWyeGround
            wyeToWyeGround "Wye to wye grounded connection"
            annotation (Placement(transformation(extent={{80,-10},{60,10}})));
        protected
          Buildings.Electrical.AC.ThreePhasesUnbalanced.Interfaces.Adapter3to3 ada "Adapter"
            annotation (Placement(transformation(extent={{32,-10},{52,10}})));
        public
          InverterLoad_PQ PQ1(V_start=V_start, V_nominal=V_start)
            annotation (Placement(transformation(extent={{0,30},{-20,50}})));
          InverterLoad_PQ PQ3(V_start=V_start, V_nominal=V_start)
            annotation (Placement(transformation(extent={{0,-50},{-20,-30}})));
          InverterLoad_PQ PQ2(V_start=V_start, V_nominal=V_start)
            annotation (Placement(transformation(extent={{0,-10},{-20,10}})));
          Interfaces.LoadCtrlBus ctrls annotation (Placement(transformation(extent={{-120,
                    -20},{-80,20}}), iconTransformation(extent={{-110,-10},{-90,10}})));
          Modelica.Blocks.Continuous.FirstOrder firstOrder1(
            T=T_const,
            initType=Modelica.Blocks.Types.Init.InitialState,
            y_start=0)
            annotation (Placement(transformation(extent={{-54,42},{-46,50}})));
          Modelica.Blocks.Continuous.FirstOrder firstOrder2(
            T=T_const,
            initType=Modelica.Blocks.Types.Init.InitialState,
            y_start=0,
            k=-1)
            annotation (Placement(transformation(extent={{-54,28},{-46,36}})));
          Modelica.Blocks.Continuous.FirstOrder firstOrder3(
            T=T_const,
            initType=Modelica.Blocks.Types.Init.InitialState,
            y_start=0)
            annotation (Placement(transformation(extent={{-54,2},{-46,10}})));
          Modelica.Blocks.Continuous.FirstOrder firstOrder4(
            T=T_const,
            initType=Modelica.Blocks.Types.Init.InitialState,
            y_start=0,
            k=-1)
            annotation (Placement(transformation(extent={{-54,-12},{-46,-4}})));
          Modelica.Blocks.Continuous.FirstOrder firstOrder5(
            T=T_const,
            initType=Modelica.Blocks.Types.Init.InitialState,
            y_start=0)
            annotation (Placement(transformation(extent={{-54,-38},{-46,-30}})));
          Modelica.Blocks.Continuous.FirstOrder firstOrder6(
            T=T_const,
            initType=Modelica.Blocks.Types.Init.InitialState,
            y_start=0,
            k=-1)
            annotation (Placement(transformation(extent={{-54,-52},{-46,-44}})));
        equation
          connect(ada.terminal, wyeToWyeGround.wyeg)
            annotation (Line(points={{52,0},{56,0},{60,0}}, color={0,120,120}));
          connect(wyeToWyeGround.wye, terminal_n)
            annotation (Line(points={{80,0},{100,0},{100,0}}, color={0,120,120}));
          connect(PQ1.terminal, ada.terminals[1]) annotation (Line(points={{0,40},{20,40},
                  {20,0.533333},{32.2,0.533333}}, color={0,120,120}));
          connect(PQ2.terminal, ada.terminals[2])
            annotation (Line(points={{0,0},{32.2,0}}, color={0,120,120}));
          connect(PQ3.terminal, ada.terminals[3]) annotation (Line(points={{0,-40},{20,-40},
                  {20,-0.533333},{32.2,-0.533333}}, color={0,120,120}));
          connect(firstOrder1.y, PQ1.Q)
            annotation (Line(points={{-45.6,46},{-22,46}}, color={0,0,127}));
          connect(firstOrder6.y, PQ3.Pow) annotation (Line(points={{-45.6,-48},{-40,-48},
                  {-40,-40},{-22,-40}}, color={0,0,127}));
          connect(firstOrder5.y, PQ3.Q)
            annotation (Line(points={{-45.6,-34},{-22,-34}}, color={0,0,127}));
          connect(firstOrder4.y, PQ2.Pow) annotation (Line(points={{-45.6,-8},{-40,-8},
                  {-40,0},{-22,0}}, color={0,0,127}));
          connect(firstOrder3.y, PQ2.Q)
            annotation (Line(points={{-45.6,6},{-22,6}}, color={0,0,127}));
          connect(firstOrder2.y, PQ1.Pow) annotation (Line(points={{-45.6,32},{-40,32},
                  {-40,40},{-22,40}}, color={0,0,127}));
          connect(firstOrder1.u, ctrls.Q1) annotation (Line(points={{-54.8,46},{-74,46},
                  {-74,0.1},{-99.9,0.1}}, color={0,0,127}), Text(
              string="%second",
              index=1,
              extent={{6,3},{6,3}}));
          connect(firstOrder2.u, ctrls.P1) annotation (Line(points={{-54.8,32},{-74,32},
                  {-74,0.1},{-99.9,0.1}}, color={0,0,127}), Text(
              string="%second",
              index=1,
              extent={{6,3},{6,3}}));
          connect(firstOrder3.u, ctrls.Q2) annotation (Line(points={{-54.8,6},{-74,6},{
                  -74,0.1},{-99.9,0.1}}, color={0,0,127}), Text(
              string="%second",
              index=1,
              extent={{6,3},{6,3}}));
          connect(firstOrder4.u, ctrls.P2) annotation (Line(points={{-54.8,-8},{-74,-8},
                  {-74,0.1},{-99.9,0.1}}, color={0,0,127}), Text(
              string="%second",
              index=1,
              extent={{6,3},{6,3}}));
          connect(firstOrder5.u, ctrls.Q3) annotation (Line(points={{-54.8,-34},{-74,
                  -34},{-74,0.1},{-99.9,0.1}}, color={0,0,127}), Text(
              string="%second",
              index=1,
              extent={{6,3},{6,3}}));
          connect(firstOrder6.u, ctrls.P3) annotation (Line(points={{-54.8,-48},{-74,
                  -48},{-74,0.1},{-99.9,0.1}}, color={0,0,127}), Text(
              string="%second",
              index=1,
              extent={{6,3},{6,3}}));
          annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
                coordinateSystem(preserveAspectRatio=false)));
        end SpotLoad_Y_PQ_extBus;

        model SpotLoad_D_PQ_extBus
          /*parameter Modelica.SIunits.ActivePower P1(start=0) "Positive = load; Negative = source";
  parameter Modelica.SIunits.ReactivePower Q1(start=0) "Positive = capacitive; Negative = inductive";
  parameter Modelica.SIunits.ActivePower P2(start=0) "Positive = load; Negative = source";
  parameter Modelica.SIunits.ReactivePower Q2(start=0) "Positive = capacitive; Negative = inductive";
  parameter Modelica.SIunits.ActivePower P3(start=0) "Positive = load; Negative = source";
  parameter Modelica.SIunits.ReactivePower Q3(start=0) "Positive = capacitive; Negative = inductive";*/
          parameter Modelica.SIunits.Voltage V_start=120;
          parameter Real T_const(unit="s")=0.01 "Time constant for firstorder";

          Buildings.Electrical.AC.ThreePhasesUnbalanced.Interfaces.Terminal_n
            terminal_n
            annotation (Placement(transformation(extent={{90,-10},{110,10}}), iconTransformation(extent={{90,-10},{110,10}})));
          Buildings.Electrical.AC.ThreePhasesUnbalanced.Interfaces.WyeToDelta
            wyeToWyeGround "Wye to wye grounded connection"
            annotation (Placement(transformation(extent={{80,-10},{60,10}})));
        protected
          Buildings.Electrical.AC.ThreePhasesUnbalanced.Interfaces.Adapter3to3 ada "Adapter"
            annotation (Placement(transformation(extent={{32,-10},{52,10}})));
        public
          InverterLoad_PQ PQ1(V_start=V_start, V_nominal=V_start)
            annotation (Placement(transformation(extent={{0,30},{-20,50}})));
          InverterLoad_PQ PQ3(V_start=V_start, V_nominal=V_start)
            annotation (Placement(transformation(extent={{0,-50},{-20,-30}})));
          InverterLoad_PQ PQ2(V_start=V_start, V_nominal=V_start)
            annotation (Placement(transformation(extent={{0,-10},{-20,10}})));
          Modelica.Blocks.Continuous.FirstOrder firstOrder1(
            T=T_const,
            initType=Modelica.Blocks.Types.Init.InitialState,
            y_start=0)
            annotation (Placement(transformation(extent={{-54,42},{-46,50}})));
          Modelica.Blocks.Continuous.FirstOrder firstOrder2(
            T=T_const,
            initType=Modelica.Blocks.Types.Init.InitialState,
            y_start=0,
            k=-1)
            annotation (Placement(transformation(extent={{-54,28},{-46,36}})));
          Modelica.Blocks.Continuous.FirstOrder firstOrder3(
            T=T_const,
            initType=Modelica.Blocks.Types.Init.InitialState,
            y_start=0)
            annotation (Placement(transformation(extent={{-54,2},{-46,10}})));
          Modelica.Blocks.Continuous.FirstOrder firstOrder4(
            T=T_const,
            initType=Modelica.Blocks.Types.Init.InitialState,
            y_start=0,
            k=-1)
            annotation (Placement(transformation(extent={{-54,-12},{-46,-4}})));
          Modelica.Blocks.Continuous.FirstOrder firstOrder5(
            T=T_const,
            initType=Modelica.Blocks.Types.Init.InitialState,
            y_start=0)
            annotation (Placement(transformation(extent={{-54,-38},{-46,-30}})));
          Modelica.Blocks.Continuous.FirstOrder firstOrder6(
            T=T_const,
            initType=Modelica.Blocks.Types.Init.InitialState,
            y_start=0,
            k=-1)
            annotation (Placement(transformation(extent={{-54,-52},{-46,-44}})));
          Interfaces.LoadCtrlBus ctrls annotation (Placement(transformation(extent={{-120,
                    -20},{-80,20}}), iconTransformation(extent={{-110,-10},{-90,10}})));
        equation
          connect(wyeToWyeGround.wye, terminal_n)
            annotation (Line(points={{80,0},{100,0}},         color={0,120,120}));
          connect(PQ1.terminal, ada.terminals[1]) annotation (Line(points={{0,40},{20,40},
                  {20,0.533333},{32.2,0.533333}}, color={0,120,120}));
          connect(PQ2.terminal, ada.terminals[2])
            annotation (Line(points={{0,0},{32.2,0}}, color={0,120,120}));
          connect(PQ3.terminal, ada.terminals[3]) annotation (Line(points={{0,-40},{20,-40},
                  {20,-0.533333},{32.2,-0.533333}}, color={0,120,120}));
          connect(ada.terminal, wyeToWyeGround.delta)
            annotation (Line(points={{52,0},{56,0},{60,0}}, color={0,120,120}));
          connect(firstOrder1.y, PQ1.Q)
            annotation (Line(points={{-45.6,46},{-22,46}}, color={0,0,127}));
          connect(firstOrder6.y, PQ3.Pow) annotation (Line(points={{-45.6,-48},{-40,-48},
                  {-40,-40},{-22,-40}}, color={0,0,127}));
          connect(firstOrder5.y, PQ3.Q)
            annotation (Line(points={{-45.6,-34},{-22,-34}}, color={0,0,127}));
          connect(firstOrder4.y, PQ2.Pow) annotation (Line(points={{-45.6,-8},{-40,-8},
                  {-40,0},{-22,0}}, color={0,0,127}));
          connect(firstOrder3.y, PQ2.Q)
            annotation (Line(points={{-45.6,6},{-22,6}}, color={0,0,127}));
          connect(firstOrder2.y, PQ1.Pow) annotation (Line(points={{-45.6,32},{-40,32},
                  {-40,40},{-22,40}}, color={0,0,127}));
          connect(firstOrder1.u, ctrls.Q1) annotation (Line(points={{-54.8,46},{-74,46},
                  {-74,0.1},{-99.9,0.1}}, color={0,0,127}), Text(
              string="%second",
              index=1,
              extent={{6,3},{6,3}}));
          connect(firstOrder2.u, ctrls.P1) annotation (Line(points={{-54.8,32},{-74,32},
                  {-74,0.1},{-99.9,0.1}}, color={0,0,127}), Text(
              string="%second",
              index=1,
              extent={{6,3},{6,3}}));
          connect(firstOrder3.u, ctrls.Q2) annotation (Line(points={{-54.8,6},{-74,6},{
                  -74,0.1},{-99.9,0.1}}, color={0,0,127}), Text(
              string="%second",
              index=1,
              extent={{6,3},{6,3}}));
          connect(firstOrder4.u, ctrls.P2) annotation (Line(points={{-54.8,-8},{-74,-8},
                  {-74,0.1},{-99.9,0.1}}, color={0,0,127}), Text(
              string="%second",
              index=1,
              extent={{6,3},{6,3}}));
          connect(firstOrder5.u, ctrls.Q3) annotation (Line(points={{-54.8,-34},{-74,
                  -34},{-74,0.1},{-99.9,0.1}}, color={0,0,127}), Text(
              string="%second",
              index=1,
              extent={{6,3},{6,3}}));
          connect(firstOrder6.u, ctrls.P3) annotation (Line(points={{-54.8,-48},{-74,
                  -48},{-74,0.1},{-99.9,0.1}}, color={0,0,127}), Text(
              string="%second",
              index=1,
              extent={{6,3},{6,3}}));
          annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
                coordinateSystem(preserveAspectRatio=false)));
        end SpotLoad_D_PQ_extBus;
      end Model;

      package Examples
        extends Modelica.Icons.ExamplesPackage;

        model Test_Inverter
          "Example to test the functionality of the inverter with battery and Pv inputs."
          extends Modelica.Icons.Example;

          Modelica.Blocks.Sources.Sine Powerfactor12(
            freqHz=1,
            phase=0,
            offset=0,
            amplitude=3000)
            annotation (Placement(transformation(extent={{80,20},{60,40}})));
          Modelica.Blocks.Sources.Constant PV123(k=4000)
            annotation (Placement(transformation(extent={{60,80},{40,100}})));
          Buildings.Electrical.AC.ThreePhasesUnbalanced.Interfaces.Adapter3to3 ada_1
            annotation (Placement(transformation(extent={{-40,-10},{-60,10}})));
          Sensor.Model.Probe3ph sens_all
            annotation (Placement(transformation(extent={{-80,-10},{-60,10}})));
          Buildings.Electrical.AC.OnePhase.Sensors.GeneralizedSensor sens1
            annotation (Placement(transformation(
                extent={{10,10},{-10,-10}},
                rotation=180,
                origin={-20,50})));
          Buildings.Electrical.AC.OnePhase.Sensors.GeneralizedSensor sens2
            annotation (Placement(transformation(
                extent={{10,10},{-10,-10}},
                rotation=180,
                origin={-20,0})));
          Buildings.Electrical.AC.OnePhase.Sensors.GeneralizedSensor sens3
            annotation (Placement(transformation(
                extent={{10,10},{-10,-10}},
                rotation=180,
                origin={-20,-50})));
          Buildings.Electrical.AC.ThreePhasesUnbalanced.Sources.FixedVoltage source(f=60, V=
                208)
            annotation (Placement(transformation(extent={{10,-10},{-10,10}},
                rotation=180,
                origin={-90,0})));
          Modelica.Blocks.Sources.Sine Powerfactor3(
            phase=0,
            offset=0,
            freqHz=0.5,
            amplitude=3000)
            annotation (Placement(transformation(extent={{80,-80},{60,-60}})));
          Model.Inverter inverter1(QIndmax=1000)
            annotation (Placement(transformation(extent={{0,40},{20,60}})));
          Model.Inverter inverter2
            annotation (Placement(transformation(extent={{0,-10},{20,10}})));
          Model.Inverter inverter3
            annotation (Placement(transformation(extent={{0,-60},{20,-40}})));
          Modelica.Blocks.Sources.Constant Battery13(k=0)
            annotation (Placement(transformation(extent={{80,60},{60,80}})));
          Modelica.Blocks.Sources.Sine Battery2(
            phase=0,
            offset=0,
            freqHz=0.5,
            amplitude=12000)
            annotation (Placement(transformation(extent={{80,-14},{60,6}})));
          Modelica.Blocks.Sources.Constant Plim13(k=1)
            annotation (Placement(transformation(extent={{-40,-100},{-20,-80}})));
          Modelica.Blocks.Sources.Step Plim2(
            height=-0.5,
            offset=1,
            startTime=10.4)
            annotation (Placement(transformation(extent={{80,-44},{60,-24}})));
          Interfaces.InvCtrlBus invCtrlBus1 annotation (Placement(transformation(extent=
                   {{0,20},{20,40}}), iconTransformation(extent={{-142,-2},{-122,18}})));
          Interfaces.InvCtrlBus invCtrlBus2 annotation (Placement(transformation(extent=
                   {{0,-30},{20,-10}}), iconTransformation(extent={{-142,-2},{-122,18}})));
          Interfaces.InvCtrlBus invCtrlBus3 annotation (Placement(transformation(extent=
                   {{0,-80},{20,-60}}), iconTransformation(extent={{-142,-2},{-122,18}})));
        equation
          connect(ada_1.terminal, sens_all.terminal_p)
            annotation (Line(points={{-60,0},{-60,0}}, color={0,120,120}));
          connect(sens1.terminal_n, ada_1.terminals[1]) annotation (Line(points={
                  {-30,50},{-34,50},{-34,0.53333},{-40.2,0.53333}}, color={0,120,
                  120}));
          connect(sens2.terminal_n, ada_1.terminals[2])
            annotation (Line(points={{-30,0},{-40.2,0}}, color={0,120,120}));
          connect(sens3.terminal_n, ada_1.terminals[3]) annotation (Line(points={
                  {-30,-50},{-34,-50},{-34,-0.53333},{-40.2,-0.53333}}, color={0,
                  120,120}));
          connect(sens_all.terminal_n, source.terminal) annotation (Line(points={
                  {-80,0},{-80,-1.33227e-015}}, color={0,120,120}));
          connect(inverter1.term_p, sens1.terminal_p) annotation (Line(points={{0,
                  50},{-5,50},{-10,50}}, color={0,120,120}));
          connect(sens2.terminal_p, inverter2.term_p)
            annotation (Line(points={{-10,0},{-5,0},{0,0}}, color={0,120,120}));
          connect(inverter3.term_p, sens3.terminal_p) annotation (Line(points={{0,
                  -50},{-5,-50},{-10,-50}}, color={0,120,120}));
          connect(PV123.y, inverter1.P_PV) annotation (Line(points={{39,90},{32,90},{32,
                  56},{22,56}}, color={0,0,127}));
          connect(PV123.y, inverter2.P_PV)
            annotation (Line(points={{39,90},{32,90},{32,6},{22,6}}, color={0,0,127}));
          connect(PV123.y, inverter3.P_PV) annotation (Line(points={{39,90},{32,90},{32,
                  -44},{22,-44}}, color={0,0,127}));
          connect(inverter1.P_Batt, inverter1.batt_ctrl_inv)
            annotation (Line(points={{22,47},{22,42},{21,42}}, color={0,0,127}));
          connect(inverter2.batt_ctrl_inv, inverter2.P_Batt)
            annotation (Line(points={{21,-8},{22,-8},{22,-3}}, color={0,0,127}));
          connect(inverter3.P_Batt, inverter3.batt_ctrl_inv) annotation (Line(points={{
                  22,-53},{22,-53},{22,-58},{21,-58}}, color={0,0,127}));
          connect(inverter1.invCtrlBus, invCtrlBus1) annotation (Line(
              points={{10,40},{10,35},{10,30}},
              color={255,204,51},
              thickness=0.5), Text(
              string="%second",
              index=1,
              extent={{6,3},{6,3}}));
          connect(inverter2.invCtrlBus, invCtrlBus2) annotation (Line(
              points={{10,-10},{10,-15},{10,-20}},
              color={255,204,51},
              thickness=0.5), Text(
              string="%second",
              index=1,
              extent={{6,3},{6,3}}));
          connect(inverter3.invCtrlBus, invCtrlBus3) annotation (Line(
              points={{10,-60},{10,-65},{10,-65},{10,-70}},
              color={255,204,51},
              thickness=0.5), Text(
              string="%second",
              index=1,
              extent={{6,3},{6,3}}));
          connect(Plim13.y, invCtrlBus1.plim) annotation (Line(points={{-19,-90},{-8,
                  -90},{-8,30.05},{10.05,30.05}}, color={0,0,127}), Text(
              string="%second",
              index=1,
              extent={{6,3},{6,3}}));
          connect(Plim13.y, invCtrlBus3.plim) annotation (Line(points={{-19,-90},{-8,
                  -90},{-8,-70},{2,-70},{2,-69.95},{10.05,-69.95}}, color={0,0,127}),
              Text(
              string="%second",
              index=1,
              extent={{6,3},{6,3}}));
          connect(Powerfactor12.y, invCtrlBus1.qctrl) annotation (Line(points={{59,30},
                  {10.05,30},{10.05,30.05}}, color={0,0,127}), Text(
              string="%second",
              index=1,
              extent={{6,3},{6,3}}));
          connect(Powerfactor12.y, invCtrlBus2.qctrl) annotation (Line(points={{59,30},
                  {40,30},{40,-20},{40,-19.95},{26,-19.95},{10.05,-19.95}}, color={0,0,
                  127}), Text(
              string="%second",
              index=1,
              extent={{6,3},{6,3}}));
          connect(Plim2.y, invCtrlBus2.plim) annotation (Line(points={{59,-34},{50,-34},
                  {50,-20},{30,-20},{30,-19.95},{10.05,-19.95}}, color={0,0,127}), Text(
              string="%second",
              index=1,
              extent={{6,3},{6,3}}));
          connect(Battery2.y, invCtrlBus2.batt_ctrl) annotation (Line(points={{59,-4},{
                  44,-4},{44,-20},{42,-20},{42,-19.95},{26,-19.95},{10.05,-19.95}},
                color={0,0,127}), Text(
              string="%second",
              index=1,
              extent={{6,3},{6,3}}));
          connect(Battery13.y, invCtrlBus1.batt_ctrl) annotation (Line(points={{59,70},
                  {36,70},{36,30.05},{10.05,30.05}}, color={0,0,127}), Text(
              string="%second",
              index=1,
              extent={{6,3},{6,3}}));
          connect(Battery13.y, invCtrlBus3.batt_ctrl) annotation (Line(points={{59,70},
                  {36,70},{36,-69.95},{10.05,-69.95}}, color={0,0,127}), Text(
              string="%second",
              index=1,
              extent={{6,3},{6,3}}));
          connect(Powerfactor3.y, invCtrlBus3.qctrl) annotation (Line(points={{59,-70},
                  {10.05,-70},{10.05,-69.95}}, color={0,0,127}), Text(
              string="%second",
              index=1,
              extent={{6,3},{6,3}}));
          annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
                coordinateSystem(preserveAspectRatio=false)));
        end Test_Inverter;

        model Test_Inverter_Qpreference
          "Example to test the functionality of the inverter with battery and Pv inputs."
          extends Modelica.Icons.Example;

          Modelica.Blocks.Sources.Sine Powerfactor12(
            freqHz=1,
            phase=0,
            offset=0,
            amplitude=10000)
            annotation (Placement(transformation(extent={{80,20},{60,40}})));
          Modelica.Blocks.Sources.Constant PV123(k=4000)
            annotation (Placement(transformation(extent={{60,80},{40,100}})));
          Buildings.Electrical.AC.OnePhase.Sensors.GeneralizedSensor sens1
            annotation (Placement(transformation(
                extent={{10,10},{-10,-10}},
                rotation=180,
                origin={-50,0})));
          Modelica.Blocks.Sources.Sine Powerfactor3(
            phase=0,
            offset=0,
            freqHz=0.5,
            amplitude=3000)
            annotation (Placement(transformation(extent={{80,-80},{60,-60}})));
          Model.Inverter inverter1
            annotation (Placement(transformation(extent={{-20,-10},{0,10}})));
          Modelica.Blocks.Sources.Constant Battery13(k=0)
            annotation (Placement(transformation(extent={{80,60},{60,80}})));
          Modelica.Blocks.Sources.Sine Battery2(
            phase=0,
            offset=0,
            freqHz=0.5,
            amplitude=4500)
            annotation (Placement(transformation(extent={{80,-14},{60,6}})));
          Modelica.Blocks.Sources.Step Plim2(
            height=-0.5,
            offset=1,
            startTime=2)
            annotation (Placement(transformation(extent={{80,-44},{60,-24}})));
          Interfaces.InvCtrlBus invCtrlBus1 annotation (Placement(transformation(extent={{-20,-40},
                    {0,-20}}),        iconTransformation(extent={{-142,-2},{-122,18}})));
          Buildings.Electrical.AC.OnePhase.Sources.FixedVoltage fixVol(f=60, V=240)
            annotation (Placement(transformation(extent={{-102,-10},{-82,10}})));
        equation
          connect(inverter1.term_p, sens1.terminal_p) annotation (Line(points={{-20,0},
                  {-40,0}},              color={0,120,120}));
          connect(inverter1.P_Batt, inverter1.batt_ctrl_inv)
            annotation (Line(points={{2,-3},{2,-8},{1,-8}},    color={0,0,127}));
          connect(inverter1.invCtrlBus, invCtrlBus1) annotation (Line(
              points={{-10,-10},{-10,-30}},
              color={255,204,51},
              thickness=0.5), Text(
              string="%second",
              index=1,
              extent={{6,3},{6,3}}));
          connect(sens1.terminal_n, fixVol.terminal)
            annotation (Line(points={{-60,0},{-82,0}}, color={0,120,120}));
          connect(Powerfactor12.y, inverter1.P_PV) annotation (Line(points={{59,30},{34,
                  30},{34,8},{2,8},{2,6}}, color={0,0,127}));
          connect(Battery13.y, invCtrlBus1.batt_ctrl) annotation (Line(points={{59,70},
                  {26,70},{26,-29.95},{-9.95,-29.95}}, color={0,0,127}), Text(
              string="%second",
              index=1,
              extent={{-6,3},{-6,3}},
              horizontalAlignment=TextAlignment.Right));
          connect(Plim2.y, invCtrlBus1.plim) annotation (Line(points={{59,-34},{26,-34},
                  {26,-29.95},{-9.95,-29.95}}, color={0,0,127}), Text(
              string="%second",
              index=1,
              extent={{-6,3},{-6,3}},
              horizontalAlignment=TextAlignment.Right));
          connect(Battery2.y, invCtrlBus1.qctrl) annotation (Line(points={{59,-4},{24,
                  -4},{24,-29.95},{-9.95,-29.95}}, color={0,0,127}), Text(
              string="%second",
              index=1,
              extent={{-6,3},{-6,3}},
              horizontalAlignment=TextAlignment.Right));
          annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
                coordinateSystem(preserveAspectRatio=false)));
        end Test_Inverter_Qpreference;

        model Test_Inverter_PI
          "Example to test the functionality of the inverter with battery and PV inputs; PI control."
          extends Modelica.Icons.Example;

          Modelica.Blocks.Sources.Sine Powerfactor12(
            amplitude=1,
            freqHz=1,
            phase=0,
            offset=0)
            annotation (Placement(transformation(extent={{80,20},{60,40}})));
          Modelica.Blocks.Sources.Constant PV123(k=4000)
            annotation (Placement(transformation(extent={{60,80},{40,100}})));
          Modelica.Blocks.Sources.Sine Powerfactor3(
            amplitude=1,
            phase=0,
            offset=0,
            freqHz=0.5)
            annotation (Placement(transformation(extent={{80,-80},{60,-60}})));
          Modelica.Blocks.Sources.Constant Battery13(k=0)
            annotation (Placement(transformation(extent={{80,60},{60,80}})));
          Modelica.Blocks.Sources.Sine Battery2(
            phase=0,
            offset=0,
            amplitude=12000,
            freqHz=1/60)
            annotation (Placement(transformation(extent={{80,-14},{60,6}})));
          Modelica.Blocks.Sources.Constant Q1(k=0)
            annotation (Placement(transformation(extent={{-40,-100},{-20,-80}})));
          Modelica.Blocks.Sources.Step Plim2(
            height=-0.5,
            offset=1,
            startTime=15)
            annotation (Placement(transformation(extent={{80,-44},{60,-24}})));
          Model.Inverter inverter_PI1
            annotation (Placement(transformation(extent={{-26,76},{-6,96}})));
          Modelica.Blocks.Sources.Sine BattControl1(
            offset=0,
            amplitude=10000,
            freqHz=1/30,
            phase=0)
            annotation (Placement(transformation(extent={{-78,50},{-58,70}})));
          Buildings.Electrical.AC.OnePhase.Sources.FixedVoltage fixVol(f=50, V=240)
            annotation (Placement(transformation(extent={{-56,26},{-36,46}})));
          Modelica.Blocks.Continuous.FirstOrder firstOrder_batt(
            k=1,
            initType=Modelica.Blocks.Types.Init.SteadyState,
            y_start=0,
            T=0.1) "Time delay for battery adjustment" annotation (Placement(
                transformation(
                extent={{-10,-10},{10,10}},
                rotation=90,
                origin={12,66})));
          Interfaces.InvCtrlBus invCtrlBus annotation (Placement(transformation(extent=
                    {{-30,50},{-10,70}}), iconTransformation(extent={{-142,-2},{-122,18}})));
        equation
          connect(fixVol.terminal, inverter_PI1.term_p) annotation (Line(points={{-36,36},
                  {-32,36},{-32,86},{-26,86}}, color={0,120,120}));
          connect(Battery2.y, inverter_PI1.P_PV) annotation (Line(points={{59,-4},{28,-4},
                  {28,92},{-4,92}}, color={0,0,127}));
          connect(firstOrder_batt.u, inverter_PI1.batt_ctrl_inv)
            annotation (Line(points={{12,54},{4,54},{4,78},{-5,78}}, color={0,0,127}));
          connect(inverter_PI1.batt_ctrl_inv, inverter_PI1.P_Batt)
            annotation (Line(points={{-5,78},{-4,78},{-4,83}}, color={0,0,127}));
          connect(inverter_PI1.invCtrlBus, invCtrlBus) annotation (Line(
              points={{-16,76},{-16,71},{-16,60},{-20,60}},
              color={255,204,51},
              thickness=0.5), Text(
              string="%second",
              index=1,
              extent={{6,3},{6,3}}));
          connect(BattControl1.y, invCtrlBus.batt_ctrl) annotation (Line(points={{-57,
                  60},{-40,60},{-40,60.05},{-19.95,60.05}}, color={0,0,127}), Text(
              string="%second",
              index=1,
              extent={{6,3},{6,3}}));
          connect(Plim2.y, invCtrlBus.plim) annotation (Line(points={{59,-34},{-20,-34},
                  {-20,60.05},{-19.95,60.05}}, color={0,0,127}), Text(
              string="%second",
              index=1,
              extent={{6,3},{6,3}}));
          connect(Q1.y, invCtrlBus.qctrl) annotation (Line(points={{-19,-90},{-19.95,
                  -90},{-19.95,60.05}}, color={0,0,127}), Text(
              string="%second",
              index=1,
              extent={{6,3},{6,3}}));
          annotation (Icon(coordinateSystem(preserveAspectRatio=false)),
          experiment(StopTime=60),
          Diagram(
                coordinateSystem(preserveAspectRatio=false)));
        end Test_Inverter_PI;

        model Test_Inverter_FMU
          "This allows the export of the inverter as FMU for testing purposes."
          extends Modelica.Icons.Example;

          Buildings.Electrical.AC.ThreePhasesUnbalanced.Interfaces.Adapter3to3 ada_1
            annotation (Placement(transformation(extent={{-40,-10},{-60,10}})));
          Sensor.Model.Probe3ph sens_all
            annotation (Placement(transformation(extent={{-80,-10},{-60,10}})));
          Buildings.Electrical.AC.OnePhase.Sensors.GeneralizedSensor sens1
            annotation (Placement(transformation(
                extent={{10,10},{-10,-10}},
                rotation=180,
                origin={-20,50})));
          Buildings.Electrical.AC.OnePhase.Sensors.GeneralizedSensor sens2
            annotation (Placement(transformation(
                extent={{10,10},{-10,-10}},
                rotation=180,
                origin={-20,0})));
          Buildings.Electrical.AC.OnePhase.Sensors.GeneralizedSensor sens3
            annotation (Placement(transformation(
                extent={{10,10},{-10,-10}},
                rotation=180,
                origin={-20,-50})));
          Buildings.Electrical.AC.ThreePhasesUnbalanced.Sources.FixedVoltage source(f=60, V=
                208)
            annotation (Placement(transformation(extent={{10,-10},{-10,10}},
                rotation=180,
                origin={-90,0})));
          Model.Inverter inverter1
            annotation (Placement(transformation(extent={{0,40},{20,60}})));
          Model.Inverter inverter2
            annotation (Placement(transformation(extent={{0,-10},{20,10}})));
          Model.Inverter inverter3
            annotation (Placement(transformation(extent={{0,-60},{20,-40}})));
          Modelica.Blocks.Interfaces.RealInput P_PV(unit="W")
            "Power generation from PV (pos if produced)" annotation (Placement(
                transformation(
                extent={{-20,-20},{20,20}},
                rotation=180,
                origin={120,50}), iconTransformation(
                extent={{-20,-20},{20,20}},
                rotation=180,
                origin={120,50})));
          Modelica.Blocks.Interfaces.RealInput P_Bat(
                                                    unit="W")
            "Power generation from PV (pos if produced)" annotation (Placement(
                transformation(
                extent={{-20,-20},{20,20}},
                rotation=180,
                origin={120,20}), iconTransformation(
                extent={{-20,-20},{20,20}},
                rotation=180,
                origin={120,20})));
          Modelica.Blocks.Interfaces.RealInput Q(unit="var") "Reactive power input"
            annotation (Placement(transformation(
                extent={{-20,-20},{20,20}},
                rotation=180,
                origin={120,-50}), iconTransformation(
                extent={{-20,-20},{20,20}},
                rotation=180,
                origin={120,-50})));
          Modelica.Blocks.Interfaces.RealInput Plim(unit="W")
            "Power limit of inverter" annotation (Placement(transformation(
                extent={{-20,-20},{20,20}},
                rotation=180,
                origin={120,-80}), iconTransformation(
                extent={{-20,-20},{20,20}},
                rotation=180,
                origin={120,50})));
          Interfaces.InvCtrlBus invCtrlBus1 annotation (Placement(transformation(extent=
                   {{20,20},{40,40}}), iconTransformation(extent={{-142,-2},{-122,18}})));
          Interfaces.InvCtrlBus invCtrlBus2 annotation (Placement(transformation(extent=
                   {{20,-30},{40,-10}}), iconTransformation(extent={{-142,-2},{-122,18}})));
          Interfaces.InvCtrlBus invCtrlBus3 annotation (Placement(transformation(extent=
                   {{20,-80},{40,-60}}), iconTransformation(extent={{-142,-2},{-122,18}})));
        equation
          connect(ada_1.terminal, sens_all.terminal_p)
            annotation (Line(points={{-60,0},{-60,0}}, color={0,120,120}));
          connect(sens1.terminal_n, ada_1.terminals[1]) annotation (Line(points={
                  {-30,50},{-34,50},{-34,0.53333},{-40.2,0.53333}}, color={0,120,
                  120}));
          connect(sens2.terminal_n, ada_1.terminals[2])
            annotation (Line(points={{-30,0},{-40.2,0}}, color={0,120,120}));
          connect(sens3.terminal_n, ada_1.terminals[3]) annotation (Line(points={
                  {-30,-50},{-34,-50},{-34,-0.53333},{-40.2,-0.53333}}, color={0,
                  120,120}));
          connect(sens_all.terminal_n, source.terminal) annotation (Line(points={
                  {-80,0},{-80,-1.33227e-015}}, color={0,120,120}));
          connect(inverter1.term_p, sens1.terminal_p)
            annotation (Line(points={{0,50},{-5,50},{-10,50}}, color={0,120,120}));
          connect(sens2.terminal_p, inverter2.term_p)
            annotation (Line(points={{-10,0},{-5,0},{0,0}}, color={0,120,120}));
          connect(inverter3.term_p, sens3.terminal_p) annotation (Line(points={{0,
                  -50},{-5,-50},{-10,-50}}, color={0,120,120}));
          connect(P_PV, inverter1.P_PV) annotation (Line(points={{120,50},{60,50},{60,
                  56},{22,56}}, color={0,0,127}));
          connect(P_PV, inverter2.P_PV) annotation (Line(points={{120,50},{60,50},{60,6},
                  {22,6}}, color={0,0,127}));
          connect(P_PV, inverter3.P_PV) annotation (Line(points={{120,50},{60,50},{60,
                  -44},{22,-44}},     color={0,0,127}));
          connect(inverter2.P_Batt, inverter2.batt_ctrl_inv)
            annotation (Line(points={{22,-3},{22,-8},{21,-8}}, color={0,0,127}));
          connect(inverter1.P_Batt, inverter1.batt_ctrl_inv)
            annotation (Line(points={{22,47},{22,42},{21,42}}, color={0,0,127}));
          connect(inverter3.P_Batt, inverter3.batt_ctrl_inv)
            annotation (Line(points={{22,-53},{22,-58},{21,-58}}, color={0,0,127}));
          connect(invCtrlBus1, inverter1.invCtrlBus) annotation (Line(
              points={{30,30},{12,30},{12,40},{10,40}},
              color={255,204,51},
              thickness=0.5), Text(
              string="%first",
              index=-1,
              extent={{-6,3},{-6,3}}));
          connect(invCtrlBus2, inverter2.invCtrlBus) annotation (Line(
              points={{30,-20},{22,-20},{10,-20},{10,-10}},
              color={255,204,51},
              thickness=0.5), Text(
              string="%first",
              index=-1,
              extent={{-6,3},{-6,3}}));
          connect(invCtrlBus3, inverter3.invCtrlBus) annotation (Line(
              points={{30,-70},{22,-70},{10,-70},{10,-60}},
              color={255,204,51},
              thickness=0.5), Text(
              string="%first",
              index=-1,
              extent={{-6,3},{-6,3}}));
          connect(P_Bat, invCtrlBus1.batt_ctrl) annotation (Line(points={{120,20},{76,
                  20},{76,30.05},{30.05,30.05}}, color={0,0,127}), Text(
              string="%second",
              index=1,
              extent={{6,3},{6,3}}));
          connect(P_Bat, invCtrlBus2.batt_ctrl) annotation (Line(points={{120,20},{76,
                  20},{76,-20},{54,-20},{54,-19.95},{30.05,-19.95}}, color={0,0,127}),
              Text(
              string="%second",
              index=1,
              extent={{6,3},{6,3}}));
          connect(P_Bat, invCtrlBus3.batt_ctrl) annotation (Line(points={{120,20},{76,
                  20},{76,-69.95},{30.05,-69.95}}, color={0,0,127}), Text(
              string="%second",
              index=1,
              extent={{6,3},{6,3}}));
          connect(Plim, invCtrlBus1.plim) annotation (Line(points={{120,-80},{76,-80},{
                  76,30.05},{30.05,30.05}}, color={0,0,127}), Text(
              string="%second",
              index=1,
              extent={{6,3},{6,3}}));
          connect(Plim, invCtrlBus3.plim) annotation (Line(points={{120,-80},{76,-80},{
                  76,-69.95},{30.05,-69.95}}, color={0,0,127}), Text(
              string="%second",
              index=1,
              extent={{6,3},{6,3}}));
          connect(Q, invCtrlBus1.qctrl) annotation (Line(points={{120,-50},{76,-50},{76,
                  30.05},{30.05,30.05}}, color={0,0,127}), Text(
              string="%second",
              index=1,
              extent={{6,3},{6,3}}));
          connect(Q, invCtrlBus2.qctrl) annotation (Line(points={{120,-50},{76,-50},{76,
                  -19.95},{30.05,-19.95}}, color={0,0,127}), Text(
              string="%second",
              index=1,
              extent={{6,3},{6,3}}));
          connect(Plim, invCtrlBus2.plim) annotation (Line(points={{120,-80},{76,-80},{
                  76,-19.95},{30.05,-19.95}}, color={0,0,127}), Text(
              string="%second",
              index=1,
              extent={{6,3},{6,3}}));
          connect(Q, invCtrlBus3.qctrl) annotation (Line(points={{120,-50},{76,-50},{76,
                  -69.95},{30.05,-69.95}}, color={0,0,127}), Text(
              string="%second",
              index=1,
              extent={{6,3},{6,3}}));
          annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
                coordinateSystem(preserveAspectRatio=false)));
        end Test_Inverter_FMU;

        model Test_InverterLoad_PQ
          "Example to test the functionality of the load model."
          extends Modelica.Icons.Example;

          Buildings.Electrical.AC.ThreePhasesUnbalanced.Interfaces.Adapter3to3 ada_1
            annotation (Placement(transformation(extent={{-40,-10},{-60,10}})));
          Sensor.Model.Probe3ph sens_all
            annotation (Placement(transformation(extent={{-80,-10},{-60,10}})));
          Buildings.Electrical.AC.OnePhase.Sensors.GeneralizedSensor sens1
            annotation (Placement(transformation(
                extent={{10,10},{-10,-10}},
                rotation=180,
                origin={-20,50})));
          Buildings.Electrical.AC.OnePhase.Sensors.GeneralizedSensor sens2
            annotation (Placement(transformation(
                extent={{10,10},{-10,-10}},
                rotation=180,
                origin={-20,0})));
          Buildings.Electrical.AC.OnePhase.Sensors.GeneralizedSensor sens3
            annotation (Placement(transformation(
                extent={{10,10},{-10,-10}},
                rotation=180,
                origin={-20,-50})));
          Buildings.Electrical.AC.ThreePhasesUnbalanced.Sources.FixedVoltage source(f=60, V=
                208)
            annotation (Placement(transformation(extent={{10,-10},{-10,10}},
                rotation=180,
                origin={-90,60})));
          Modelica.Blocks.Sources.Sine Qsine1(
            phase=0,
            offset=0,
            freqHz=1,
            amplitude=250)
            annotation (Placement(transformation(extent={{60,-40},{40,-20}})));
          Modelica.Blocks.Sources.Sine Psine1(
            phase=0,
            offset=0,
            freqHz=0.5,
            amplitude=1000)
            annotation (Placement(transformation(extent={{80,-10},{60,10}})));
          Model.InverterLoad_PQ Load1(V_nominal=120)
            annotation (Placement(transformation(extent={{0,40},{20,60}})));
          Model.InverterLoad_PQ Load2(V_nominal=120)
            annotation (Placement(transformation(extent={{0,-10},{20,10}})));
          Model.InverterLoad_PQ Load3(V_nominal=120)
            annotation (Placement(transformation(extent={{0,-60},{20,-40}})));
          Modelica.Blocks.Sources.Constant Qfixed2(k=250)
            annotation (Placement(transformation(extent={{60,20},{40,40}})));
          Modelica.Blocks.Sources.Constant Pfixed(k=1000)
            annotation (Placement(transformation(extent={{80,40},{60,60}})));
          Modelica.Blocks.Sources.Constant Qfixed1(k=-250)
            annotation (Placement(transformation(extent={{60,60},{40,80}})));
          Modelica.Blocks.Sources.Constant Pfixed1(k=-1000)
            annotation (Placement(transformation(extent={{80,-60},{60,-40}})));
          Buildings.Electrical.AC.ThreePhasesUnbalanced.Lines.TwoPortMatrixRL FL_feed(
            Z12=20*(1.0/5280.0)*{0.0953,0.8515},
            Z13=20*(1.0/5280.0)*{0.0953,0.7266},
            Z23=20*(1.0/5280.0)*{0.0953,0.7802},
            V_nominal=208,
            Z11=20*(1.0/5280.0)*{0.4013,1.4133},
            Z22=20*(1.0/5280.0)*{0.4013,1.4133},
            Z33=20*(1.0/5280.0)*{0.4013,1.4133}) annotation (Placement(transformation(
                extent={{-10,10},{10,-10}},
                rotation=-90,
                origin={-80,30})));
        equation
          connect(ada_1.terminal, sens_all.terminal_p)
            annotation (Line(points={{-60,0},{-60,0}}, color={0,120,120}));
          connect(sens1.terminal_n, ada_1.terminals[1]) annotation (Line(points={
                  {-30,50},{-34,50},{-34,0.53333},{-40.2,0.53333}}, color={0,120,
                  120}));
          connect(sens2.terminal_n, ada_1.terminals[2])
            annotation (Line(points={{-30,0},{-40.2,0}}, color={0,120,120}));
          connect(sens3.terminal_n, ada_1.terminals[3]) annotation (Line(points={
                  {-30,-50},{-34,-50},{-34,-0.53333},{-40.2,-0.53333}}, color={0,
                  120,120}));
          connect(Load1.terminal, sens1.terminal_p)
            annotation (Line(points={{0,50},{-10,50}}, color={0,120,120}));
          connect(sens2.terminal_p, Load2.terminal)
            annotation (Line(points={{-10,0},{-5,0},{0,0}}, color={0,120,120}));
          connect(sens3.terminal_p, Load3.terminal)
            annotation (Line(points={{-10,-50},{-5,-50},{0,-50}}, color={0,120,120}));
          connect(Pfixed.y, Load1.Pow)
            annotation (Line(points={{59,50},{40.5,50},{22,50}}, color={0,0,127}));
          connect(Load3.Q, Qsine1.y) annotation (Line(points={{22,-44},{30,-44},{30,-30},
                  {39,-30}}, color={0,0,127}));
          connect(Qfixed2.y, Load2.Q)
            annotation (Line(points={{39,30},{32,30},{32,6},{22,6}}, color={0,0,127}));
          connect(Qfixed1.y, Load1.Q) annotation (Line(points={{39,70},{32,70},{32,56},
                  {22,56}}, color={0,0,127}));
          connect(sens_all.terminal_n, FL_feed.terminal_p)
            annotation (Line(points={{-80,0},{-80,20}}, color={0,120,120}));
          connect(FL_feed.terminal_n, source.terminal)
            annotation (Line(points={{-80,40},{-80,60}}, color={0,120,120}));
          connect(Pfixed1.y, Load3.Pow)
            annotation (Line(points={{59,-50},{22,-50},{22,-50}}, color={0,0,127}));
          connect(Qfixed2.y, Load2.Pow)
            annotation (Line(points={{39,30},{32,30},{32,0},{22,0}}, color={0,0,127}));
          annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
                coordinateSystem(preserveAspectRatio=false)));
        end Test_InverterLoad_PQ;

        model Test_InverterLoad_pf
           "Example to test the functionality of the load model."
          extends Modelica.Icons.Example;

          Model.InverterLoad_pf inverterLoad_pf
            annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
          Modelica.Blocks.Sources.Sine pf1(
            offset=0,
            freqHz=1,
            amplitude=1,
            phase=0.78539816339745)
            annotation (Placement(transformation(extent={{60,10},{40,30}})));
          Modelica.Blocks.Sources.Sine Psine1(
            phase=0,
            offset=0,
            freqHz=0.5,
            amplitude=1000)
            annotation (Placement(transformation(extent={{80,-10},{60,10}})));
          Buildings.Electrical.AC.OnePhase.Sources.FixedVoltage fixVol(f=60, V=120)
            annotation (Placement(transformation(extent={{-60,-10},{-40,10}})));
        equation
          connect(inverterLoad_pf.Pow, Psine1.y)
            annotation (Line(points={{12,0},{59,0}}, color={0,0,127}));
          connect(inverterLoad_pf.pf_in, pf1.y)
            annotation (Line(points={{12,6},{28,6},{28,20},{39,20}}, color={0,0,127}));
          connect(fixVol.terminal, inverterLoad_pf.terminal)
            annotation (Line(points={{-40,0},{-25,0},{-10,0}}, color={0,120,120}));
          annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
                coordinateSystem(preserveAspectRatio=false)));
        end Test_InverterLoad_pf;

        model Test_SpotLoads
            extends Modelica.Icons.Example;

          Model.SpotLoad_Y_PQ spotLoad_Y_PQ(
            P1=1000,
            P2=500,
            P3=250,
            V_start=120,
            Q1=-250,
            Q2=-500,
            Q3=-1000) annotation (Placement(transformation(extent={{-50,40},{-30,60}})));
          Model.SpotLoad_D_PQ spotLoad_D_PQ(
            P1=1000,
            Q1=-250,
            P2=500,
            Q2=-500,
            P3=250,
            Q3=-1000,
            V_start=120)
            annotation (Placement(transformation(extent={{-50,-50},{-30,-30}})));
          Buildings.Electrical.AC.ThreePhasesUnbalanced.Sources.Grid grid_Y(f=60, V=120)
            annotation (Placement(transformation(extent={{50,60},{70,80}})));
          Buildings.Electrical.AC.ThreePhasesUnbalanced.Sources.Grid grid_D(f=60, V=120)
            annotation (Placement(transformation(extent={{50,-30},{70,-10}})));
          Sensor.Model.Probe3ph sens_Y(V_nominal=120)
            annotation (Placement(transformation(extent={{10,40},{-10,60}})));
          Sensor.Model.Probe3ph sens_D(V_nominal=120)
            annotation (Placement(transformation(extent={{10,-50},{-10,-30}})));
          Buildings.Electrical.AC.ThreePhasesUnbalanced.Lines.Line line_Y(
            l=1000,
            P_nominal=5000,
            V_nominal=120)
            annotation (Placement(transformation(extent={{40,40},{20,60}})));
          Buildings.Electrical.AC.ThreePhasesUnbalanced.Lines.Line line_D(
            l=1000,
            P_nominal=5000,
            V_nominal=120)
            annotation (Placement(transformation(extent={{40,-50},{20,-30}})));
          Model.SpotLoad_Y_PQ spotLoad_Y_PQcap(
            P1=1000,
            P2=500,
            P3=250,
            V_start=120,
            Q1=250,
            Q2=500,
            Q3=1000) annotation (Placement(transformation(extent={{-50,10},{-30,30}})));
          Sensor.Model.Probe3ph sens_Ycap(V_nominal=120)
            annotation (Placement(transformation(extent={{10,10},{-10,30}})));
          Buildings.Electrical.AC.ThreePhasesUnbalanced.Lines.Line line_Ycap(
            l=1000,
            P_nominal=5000,
            V_nominal=120)
            annotation (Placement(transformation(extent={{40,10},{20,30}})));
          Model.SpotLoad_D_PQ spotLoad_D_PQcap(
            P1=1000,
            P2=500,
            P3=250,
            V_start=120,
            Q1=250,
            Q2=500,
            Q3=1000)
            annotation (Placement(transformation(extent={{-50,-80},{-30,-60}})));
          Sensor.Model.Probe3ph sens_Dcap(V_nominal=120)
            annotation (Placement(transformation(extent={{10,-80},{-10,-60}})));
          Buildings.Electrical.AC.ThreePhasesUnbalanced.Lines.Line line_Dcap(
            l=1000,
            P_nominal=5000,
            V_nominal=120)
            annotation (Placement(transformation(extent={{40,-80},{20,-60}})));
        equation
          connect(sens_Y.terminal_p, spotLoad_Y_PQ.terminal_n)
            annotation (Line(points={{-10,50},{-10,50},{-30,50}}, color={0,120,120}));
          connect(spotLoad_D_PQ.terminal_n, sens_D.terminal_p) annotation (Line(points={
                  {-30,-40},{-24,-40},{-10,-40}}, color={0,120,120}));
          connect(grid_Y.terminal, line_Y.terminal_n)
            annotation (Line(points={{60,60},{60,50},{40,50}}, color={0,120,120}));
          connect(line_Y.terminal_p, sens_Y.terminal_n)
            annotation (Line(points={{20,50},{10,50}}, color={0,120,120}));
          connect(sens_D.terminal_n, line_D.terminal_p)
            annotation (Line(points={{10,-40},{20,-40}}, color={0,120,120}));
          connect(line_D.terminal_n, grid_D.terminal)
            annotation (Line(points={{40,-40},{60,-40},{60,-30}}, color={0,120,120}));
          connect(sens_Ycap.terminal_p, spotLoad_Y_PQcap.terminal_n)
            annotation (Line(points={{-10,20},{-10,20},{-30,20}}, color={0,120,120}));
          connect(grid_Y.terminal, line_Ycap.terminal_n)
            annotation (Line(points={{60,60},{60,20},{40,20}}, color={0,120,120}));
          connect(sens_Ycap.terminal_n, line_Ycap.terminal_p)
            annotation (Line(points={{10,20},{14,20},{20,20}}, color={0,120,120}));
          connect(spotLoad_D_PQcap.terminal_n, sens_Dcap.terminal_p) annotation (Line(
                points={{-30,-70},{-30,-70},{-10,-70}}, color={0,120,120}));
          connect(line_Dcap.terminal_n, grid_D.terminal)
            annotation (Line(points={{40,-70},{60,-70},{60,-30}}, color={0,120,120}));
          connect(sens_Dcap.terminal_n, line_Dcap.terminal_p)
            annotation (Line(points={{10,-70},{20,-70}}, color={0,120,120}));
          annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
                coordinateSystem(preserveAspectRatio=false)));
        end Test_SpotLoads;

        model Test_Spotload_FMU
          Model.SpotLoad_Y_PQ_ext spotLoad_Y_PQ_ext
            annotation (Placement(transformation(extent={{-40,-20},{-20,20}})));
          Modelica.Blocks.Interfaces.RealInput P1(start=0, unit="W") "Positive = load; Negative = source" annotation (
              Placement(transformation(
                extent={{20,-20},{-20,20}},
                rotation=180,
                origin={-120,80}), iconTransformation(
                extent={{10,-10},{-10,10}},
                rotation=180,
                origin={-110,80})));
          Modelica.Blocks.Interfaces.RealInput Q1(start=0, unit="var") "Positive = capacitive; Negative = inductive" annotation (
              Placement(transformation(
                extent={{20,-20},{-20,20}},
                rotation=180,
                origin={-120,50}), iconTransformation(
                extent={{10,-10},{-10,10}},
                rotation=180,
                origin={-110,50})));
          Modelica.Blocks.Interfaces.RealInput P2(start=0, unit="W") "Positive = load; Negative = source" annotation (
              Placement(transformation(
                extent={{20,-20},{-20,20}},
                rotation=180,
                origin={-120,10}), iconTransformation(
                extent={{10,-10},{-10,10}},
                rotation=180,
                origin={-110,10})));
          Modelica.Blocks.Interfaces.RealInput Q2(start=0, unit="var") "Positive = capacitive; Negative = inductive" annotation (
              Placement(transformation(
                extent={{20,-20},{-20,20}},
                rotation=180,
                origin={-120,-20}),iconTransformation(
                extent={{10,-10},{-10,10}},
                rotation=180,
                origin={-110,-20})));
          Modelica.Blocks.Interfaces.RealInput P3(start=0, unit="W") "Positive = load; Negative = source" annotation (
              Placement(transformation(
                extent={{20,-20},{-20,20}},
                rotation=180,
                origin={-120,-60}),iconTransformation(
                extent={{10,-10},{-10,10}},
                rotation=180,
                origin={-110,-60})));
          Modelica.Blocks.Interfaces.RealInput Q3(start=0, unit="var") "Positive = capacitive; Negative = inductive" annotation (
              Placement(transformation(
                extent={{20,-20},{-20,20}},
                rotation=180,
                origin={-120,-90}),iconTransformation(
                extent={{10,-10},{-10,10}},
                rotation=180,
                origin={-110,-90})));
          Buildings.Electrical.AC.ThreePhasesUnbalanced.Sources.Grid grid_Y(f=60, V=120)
            annotation (Placement(transformation(extent={{50,60},{70,80}})));
          Sensor.Model.Probe3ph sens_Y(V_nominal=120)
            annotation (Placement(transformation(extent={{10,-10},{-10,10}})));
          Buildings.Electrical.AC.ThreePhasesUnbalanced.Lines.Line line_Y(
            l=1000,
            P_nominal=5000,
            V_nominal=120)
            annotation (Placement(transformation(extent={{40,-10},{20,10}})));
          Modelica.Blocks.Continuous.FirstOrder firstOrder1(T=0.1)
            annotation (Placement(transformation(extent={{-94,76},{-86,84}})));
          Modelica.Blocks.Continuous.FirstOrder firstOrder2(T=0.1)
            annotation (Placement(transformation(extent={{-94,46},{-86,54}})));
          Modelica.Blocks.Continuous.FirstOrder firstOrder3(T=0.1)
            annotation (Placement(transformation(extent={{-94,6},{-86,14}})));
          Modelica.Blocks.Continuous.FirstOrder firstOrder4(T=0.1)
            annotation (Placement(transformation(extent={{-94,-24},{-86,-16}})));
          Modelica.Blocks.Continuous.FirstOrder firstOrder5(T=0.1)
            annotation (Placement(transformation(extent={{-94,-64},{-86,-56}})));
          Modelica.Blocks.Continuous.FirstOrder firstOrder6(T=0.1)
            annotation (Placement(transformation(extent={{-94,-94},{-86,-86}})));
        equation
          connect(grid_Y.terminal,line_Y. terminal_n)
            annotation (Line(points={{60,60},{60,0},{40,0}},   color={0,120,120}));
          connect(line_Y.terminal_p,sens_Y. terminal_n)
            annotation (Line(points={{20,0},{10,0}},   color={0,120,120}));
          connect(sens_Y.terminal_p, spotLoad_Y_PQ_ext.terminal_n)
            annotation (Line(points={{-10,0},{-20,0}}, color={0,120,120}));
          connect(spotLoad_Y_PQ_ext.P1, firstOrder1.y) annotation (Line(points={{-41,16},
                  {-60,16},{-60,80},{-85.6,80}}, color={0,0,127}));
          connect(firstOrder1.u, P1)
            annotation (Line(points={{-94.8,80},{-120,80}}, color={0,0,127}));
          connect(Q1, firstOrder2.u)
            annotation (Line(points={{-120,50},{-94.8,50}}, color={0,0,127}));
          connect(firstOrder2.y, spotLoad_Y_PQ_ext.Q1) annotation (Line(points={{-85.6,
                  50},{-70,50},{-70,10},{-41,10}}, color={0,0,127}));
          connect(P2, firstOrder3.u)
            annotation (Line(points={{-120,10},{-94.8,10}}, color={0,0,127}));
          connect(firstOrder3.y, spotLoad_Y_PQ_ext.P2) annotation (Line(points={{-85.6,
                  10},{-80,10},{-80,2},{-41,2}}, color={0,0,127}));
          connect(Q2, firstOrder4.u)
            annotation (Line(points={{-120,-20},{-94.8,-20}}, color={0,0,127}));
          connect(firstOrder4.y, spotLoad_Y_PQ_ext.Q2) annotation (Line(points={{-85.6,
                  -20},{-80,-20},{-80,-4},{-41,-4}}, color={0,0,127}));
          connect(spotLoad_Y_PQ_ext.P3, firstOrder5.y) annotation (Line(points={{-41,
                  -12},{-70,-12},{-70,-60},{-85.6,-60}}, color={0,0,127}));
          connect(firstOrder5.u, P3)
            annotation (Line(points={{-94.8,-60},{-120,-60}}, color={0,0,127}));
          connect(spotLoad_Y_PQ_ext.Q3, firstOrder6.y) annotation (Line(points={{-41,
                  -18},{-60,-18},{-60,-90},{-85.6,-90}}, color={0,0,127}));
          connect(firstOrder6.u, Q3)
            annotation (Line(points={{-94.8,-90},{-120,-90}}, color={0,0,127}));
          annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
                coordinateSystem(preserveAspectRatio=false)));
        end Test_Spotload_FMU;

        model Test_Spotload_Bus_FMU
          Model.SpotLoad_Y_PQ_extBus spotLoad_Y_PQ_ext
            annotation (Placement(transformation(extent={{-40,-10},{-20,10}})));
          Buildings.Electrical.AC.ThreePhasesUnbalanced.Sources.Grid grid_Y(f=60, V=120)
            annotation (Placement(transformation(extent={{50,60},{70,80}})));
          Sensor.Model.Probe3ph sens_Y(V_nominal=120)
            annotation (Placement(transformation(extent={{10,-10},{-10,10}})));
          Buildings.Electrical.AC.ThreePhasesUnbalanced.Lines.Line line_Y(
            V_nominal=120,
            P_nominal=50000,
            l=10000)
            annotation (Placement(transformation(extent={{40,-10},{20,10}})));
          Interfaces.LoadCtrlBus loadCtrlBus annotation (Placement(transformation(
                  extent={{-120,-20},{-80,20}}), iconTransformation(extent={{-114,-30},
                    {-94,-10}})));
        equation
          connect(grid_Y.terminal,line_Y. terminal_n)
            annotation (Line(points={{60,60},{60,0},{40,0}},   color={0,120,120}));
          connect(line_Y.terminal_p,sens_Y. terminal_n)
            annotation (Line(points={{20,0},{10,0}},   color={0,120,120}));
          connect(sens_Y.terminal_p, spotLoad_Y_PQ_ext.terminal_n)
            annotation (Line(points={{-10,0},{-16,0},{-20,0}}, color={0,120,120}));
          connect(loadCtrlBus, spotLoad_Y_PQ_ext.ctrls) annotation (Line(
              points={{-100,0},{-70,0},{-40,0}},
              color={255,204,51},
              thickness=0.5), Text(
              string="%first",
              index=-1,
              extent={{-6,3},{-6,3}}));
          annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
                coordinateSystem(preserveAspectRatio=false)));
        end Test_Spotload_Bus_FMU;
      end Examples;

      package Interfaces

        model Load_partial "Partial model for a generic load"
          replaceable package PhaseSystem =
              Buildings.Electrical.PhaseSystems.PartialPhaseSystem constrainedby
            Buildings.Electrical.PhaseSystems.PartialPhaseSystem "Phase system"
            annotation (choicesAllMatching=true);
          /*parameter Boolean linearized = false "If true, the load model is linearized"
  annotation(Evaluate=true,Dialog(group="Modeling assumption"));
  */
          /*parameter Buildings.Electrical.Types.Load mode(
    min=Buildings.Electrical.Types.Load.FixedZ_steady_state,
    max=Buildings.Electrical.Types.Load.VariableZ_y_input) = Buildings.Electrical.Types.Load.FixedZ_steady_state
    "Type of load model (e.g., steady state, dynamic, prescribed power consumption, etc.)"
    annotation (Evaluate=true, Dialog(group="Modeling assumption"));
    */
          /*
  parameter Modelica.SIunits.Power P_nominal = 0
    "Nominal power (negative if consumed, positive if generated). Used if mode <> Buildings.Electrical.Types.Load.VariableZ_P_input"
    annotation(Dialog(group="Nominal conditions",
    enable = mode <> Buildings.Electrical.Types.Load.VariableZ_P_input));
    */

          parameter Modelica.SIunits.Voltage V_nominal(min=0, start=110)
            "Nominal voltage (V_nominal >= 0)"
            annotation (
              Evaluate=true,
              Dialog(group="Nominal conditions",
              enable = (mode==Buildings.Electrical.Types.Load.FixedZ_dynamic or linearized)));
          parameter Buildings.Electrical.Types.InitMode initMode(
          min=Buildings.Electrical.Types.InitMode.zero_current,
          max=Buildings.Electrical.Types.InitMode.linearized) = Buildings.Electrical.Types.InitMode.zero_current
            "Initialization mode for homotopy operator"  annotation(Dialog(tab = "Initialization"));

          Modelica.SIunits.Voltage v[:](start = PhaseSystem.phaseVoltages(V_nominal)) = terminal.v
            "Voltage vector";
          Modelica.SIunits.Current i[:] = terminal.i
            "Current vector";
          Modelica.SIunits.Power S[PhaseSystem.n] = PhaseSystem.phasePowers_vi(v, -i)
            "Phase powers";
          Modelica.SIunits.Power P
            "Power of the load (negative if consumed, positive if fed into the electrical grid)";

          /*
  Modelica.Blocks.Interfaces.RealInput y(min=0, max=1, unit="1") if 
       (mode == Buildings.Electrical.Types.Load.VariableZ_y_input)
    "Fraction of the nominal power consumed" annotation (Placement(transformation(
        extent={{-20,-20},{20,20}},
        rotation=180,
        origin={100,0}), iconTransformation(
        extent={{-20,-20},{20,20}},
        rotation=180,
        origin={100,0})));
  Modelica.Blocks.Interfaces.RealInput Pow(unit="W") if 
       (mode == Buildings.Electrical.Types.Load.VariableZ_P_input)
    "Power consumed" annotation (Placement(transformation(
        extent={{-20,-20},{20,20}},
        rotation=180,
        origin={100,0}), iconTransformation(
        extent={{-20,-20},{20,20}},
        rotation=180,
        origin={100,0})));
        */
          Modelica.Blocks.Interfaces.RealInput Pow(unit="W") "Power consumed"
                             annotation (Placement(transformation(
                extent={{-20,-20},{20,20}},
                rotation=180,
                origin={120,0}), iconTransformation(
                extent={{-20,-20},{20,20}},
                rotation=180,
                origin={120,0})));
          replaceable Buildings.Electrical.Interfaces.Terminal terminal(
            redeclare replaceable package PhaseSystem = PhaseSystem)
            "Generalized electric terminal"
            annotation (Placement(transformation(extent={{-108,-8},{-92,8}}),
                iconTransformation(extent={{-108,-8},{-92,8}})));

        protected
          Modelica.Blocks.Interfaces.RealInput y_internal
            "Hidden value of the input load for the conditional connector";
          Modelica.Blocks.Interfaces.RealInput P_internal
            "Hidden value of the input power for the conditional connector";
          Real load(min=eps, max=1)
            "Internal representation of control signal, used to avoid singularity";
          constant Real eps = 1E-10
            "Small number used to avoid a singularity if the power is zero";
          constant Real oneEps = 1-eps
            "Small number used to avoid a singularity if the power is zero";

        initial equation
          /*
  if mode == Buildings.Electrical.Types.Load.VariableZ_P_input then
    assert(abs(P_nominal) < 1E-10, "*** Warning: P_nominal = " + String(P_nominal) + ", but this value will be ignored.",
           AssertionLevel.warning);
           end if;
           */
        equation
          //assert(y_internal>=0 and y_internal<=1+eps, "The power load fraction P (input of the model) must be within [0,1]");

          // Connection between the conditional and inner connector
          //connect(y,y_internal);
          connect(Pow,P_internal);

          // If the power is fixed, inner connector value is equal to 1
          /*
  if mode==Buildings.Electrical.Types.Load.FixedZ_steady_state or 
     mode==Buildings.Electrical.Types.Load.FixedZ_dynamic then
    y_internal   = 1;
    P_internal = 0;
  elseif mode==Buildings.Electrical.Types.Load.VariableZ_y_input then
    P_internal = 0;
  elseif mode==Buildings.Electrical.Types.Load.VariableZ_P_input then
    y_internal = 1;
    end if;
    */
          y_internal = 1;

          // Value of the load, depending on the type: fixed or variable
          /*
  if mode==Buildings.Electrical.Types.Load.VariableZ_y_input then
    load = eps + oneEps*y_internal;
  else
    load = 1;
    end if;
    */
          load = 1;

          // Power consumption
          /*
  if mode==Buildings.Electrical.Types.Load.FixedZ_steady_state or 
     mode==Buildings.Electrical.Types.Load.FixedZ_dynamic then
    P = P_nominal;
  elseif mode==Buildings.Electrical.Types.Load.VariableZ_P_input then
    P = P_internal;
  else
    P = P_nominal*load;
    end if;
    */
          P = P_internal;

          annotation ( Documentation(revisions="<html>
<ul>
<li>
November 28, 2016, by Michael Wetter:<br/>
Removed zero start value for current.
The current is typically non-zero and zero is anyway the default start value, hence there is no need to set it.<br/>
This is for
<a href=\"https://github.com/lbl-srg/modelica-buildings/issues/584\">#584</a>.
</li>
<li>
September 17, 2016, by Michael Wetter:<br/>
Corrected wrong annotation to avoid an error in the pedantic model check
in Dymola 2017 FD01 beta2.<br/>
This is for
<a href=\"https://github.com/lbl-srg/modelica-buildings/issues/557\">issue 557</a>.
</li> 
<li>
February 26, 2016, by Michael Wetter:<br/>
Set default value for <code>P_nominal</code>
and removed assertion warning.
This is required for pedantic model check in Dymola.
This is for
<a href=\"https://github.com/lbl-srg/modelica-buildings/issues/426\">#426</a>.
</li>
<li>
September 24, 2015 by Michael Wetter:<br/>
Provided value for <code>P_nominal</code> if
<code>mode &lt;&gt; Buildings.Electrical.Types.Load.VariableZ_P_input</code>.
This avoids a warning during translation of
<a href=\"modelica://Buildings.Examples.ChillerPlant.DataCenterRenewables\">
Buildings.Examples.ChillerPlant.DataCenterRenewables</a>.
</li>
<li>
September 4, 2014, by Michael Wetter:<br/>
Changed the parameter from <code>linear</code> to <code>linearized</code>
because <code>Buildings.Fluid</code> also uses <code>linearized</code>.
This change has been done to use a consistent naming across the library.
</li>
<li>June 17, 2014, by Marco Bonvini:<br/>
Adde parameter <code>initMode</code> that can be used to
select the assumption to be used during initialization phase
by the homotopy operator.
</li>
<li>
May 15, 2014, by Marco Bonvini:<br/>
Created documentation and revised model.
</li>
<li>
October 31, 2013, by Marco Bonvini:<br/>
Model included in the Buildings library.
</li>
</ul>
</html>",         info="<html>
<p>
This model represents a generic load that can be extended to represent
either a DC or an AC load.
</p>
<p>
The model has a single generalized electric terminal of type
<a href=\"modelica://Buildings.Electrical.Interfaces.Terminal\">
Buildings.Electrical.Interfaces.Terminal</a>
that can be redeclared.
The generalized load is modeled as an impedance whose value can change. The value of the impedance
can change depending on the value of the parameter <code>mode</code>, which is of type
<a href=\"Buildings.Electrical.Types.Load\">Buildings.Electrical.Types.Load</a>:
</p>

<table summary=\"summary\" border=\"1\" cellspacing=\"0\" cellpadding=\"2\" style=\"border-collapse:collapse;\">
<tr>
<th>Mode</th>
<th>Description</th>
<th>Explanation</th>
</tr>
<!-- ************ -->
<tr>
<td>Buildings.Electrical.Types.Load.FixedZ_steady_state</td>
<td>fixed Z steady state</td>
<td>The load consumes exactly the power
specified by the parameter <code>P_nominal</code>.
</td>
</tr>
<!-- ************ -->
<tr>
<td>Buildings.Electrical.Types.Load.FixedZ_dynamic</td>
<td>fixed Z dynamic</td>
<td>
The load consumes exactly the power
specified by the parameter <code>P_nominal</code> at steady state.
Depending on the type
of load (e.g., inductive or capacitive)
different dynamics are represented.
</td>
</tr>
<!-- ************ -->
<tr>
<td>Buildings.Electrical.Types.Load.VariableZ_P_input</td>
<td>variable Z P input</td>
<td>
The load consumes exactly the power specified
by the input variable <code>Pow</code>.
</td>
</tr>
<!-- ************ -->
<tr>
<td>Buildings.Electrical.Types.Load.VariableZ_y_input</td>
<td>variable Z y input</td>
<td>
The load consumes exactly the a fraction of the nominal power
<code>P_nominal</code> specified by the input variable <code>y</code>.
</td>
</tr>
<!-- ************ -->
</table>


<h4>Conventions</h4>
<p>
It is assumed that the power <code>P</code> of the load is positive when produced
(e.g., the load acts like a source) and negative when consumed (e.g., the
source acts like a utilizer).
</p>

<h4>Linearized models</h4>
<p>
The model has a Boolean parameter <code>linearized</code> that by default is equal to <code>false</code>.
When the power consumption of the load is imposed, this introduces
a nonlinear equation between the voltage and the current of the load. This flag is used to
select between a linearized version
of the equations or the original nonlinear ones.<br/>
When the linearized version of the model is used, the parameter <code>V_nominal</code> has to
be specified. The nominal voltage is needed to linearize the nonlinear equations.<br/>
</p>
<p>
<b>Note:</b>
A linearized model will not consume the nominal power if the voltage
at the terminal differs from the nominal voltage.
</p>

</html>"));
        end Load_partial;

        expandable connector InvCtrlBus
          "Control bus for inverter control"
          extends Modelica.Icons.SignalBus;
          Real qctrl( start=0, unit="var") "Reactive power control for Inverter" annotation (HideResult=false);
          Real plim( start=1, min=0, max=1, unit="1") "Power limit control for Inverter" annotation (HideResult=false);
          Real batt_ctrl( start=0, unit="W") "Power control for Battery" annotation (HideResult=false);
          Real p( start=0, unit="W") "Measured AC active power" annotation (HideResult=false);
          Real q( start=0, unit="var") "Measured AC reactive power" annotation (HideResult=false);
          Real v( start=120, unit="V") "Measured AC voltage" annotation (HideResult=false);
           annotation (Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,
                    -100},{100,100}}), graphics={Rectangle(
                          extent={{-20,2},{22,-2}},
                          lineColor={255,204,51},
                          lineThickness=0.5)}));

        end InvCtrlBus;

        expandable connector SiteCtrlBus "Control bus for a site of  inverter control"
          extends Modelica.Icons.SignalBus;
          Real pf1( start=1, min=0, max=1, unit="1") "Power factor control for Inverter 1" annotation (HideResult=false);
          Real plim1( start=1, min=0, max=1, unit="1") "Power limit control for Inverter 1" annotation (HideResult=false);
          Real batt_ctrl1( start=0, unit="W") "Power control for Battery 1" annotation (HideResult=false);
          Real pf2( start=1, min=0, max=1, unit="1") "Power factor control for Inverter 2" annotation (HideResult=false);
          Real plim2( start=1, min=0, max=1, unit="1") "Power limit control for Inverter 2" annotation (HideResult=false);
          Real batt_ctrl2( start=0, unit="W") "Power control for Battery 2" annotation (HideResult=false);
          Real pf3( start=1, min=0, max=1, unit="1") "Power factor control for Inverter 3" annotation (HideResult=false);
          Real plim3( start=1, min=0, max=1, unit="1") "Power limit control for Inverter 3" annotation (HideResult=false);
          Real batt_ctrl3( start=0, unit="W") "Power control for Battery 3" annotation (HideResult=false);
          annotation (Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,
                    -100},{100,100}}), graphics={Rectangle(
                          extent={{-20,2},{22,-2}},
                          lineColor={255,204,51},
                          lineThickness=0.5)}));

        end SiteCtrlBus;

        expandable connector InvCtrlBus_pf "Control bus for inverter control"
          extends Modelica.Icons.SignalBus;
          Real pf( start=1, min=0, max=1, unit="1") "Power factor control for Inverter" annotation (HideResult=false);
          Real plim( start=1, min=0, max=1, unit="1") "Power limit control for Inverter" annotation (HideResult=false);
          Real batt_ctrl( start=0, unit="W") "Power control for Battery" annotation (HideResult=false);
          Real p( start=0, unit="W") "Measured AC active power" annotation (HideResult=false);
          Real q( start=0, unit="var") "Measured AC reactive power" annotation (HideResult=false);
          Real v( start=120, unit="V") "Measured AC voltage" annotation (HideResult=false);
           annotation (Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,
                    -100},{100,100}}), graphics={Rectangle(
                          extent={{-20,2},{22,-2}},
                          lineColor={255,204,51},
                          lineThickness=0.5)}));

        end InvCtrlBus_pf;

        expandable connector LoadCtrlBus "Control bus for load control"
          extends Modelica.Icons.SignalBus;
          Real P1(start=0, unit="W") "Positive = load; Negative = source";
          Real Q1(start=0, unit="var") "Positive = capacitive; Negative = inductive";
          Real P2(start=0, unit="W") "Positive = load; Negative = source";
          Real Q2(start=0, unit="var") "Positive = capacitive; Negative = inductive";
          Real P3(start=0, unit="W") "Positive = load; Negative = source";
          Real Q3(start=0, unit="var") "Positive = capacitive; Negative = inductive";

           annotation (Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,
                    -100},{100,100}}), graphics={Rectangle(
                          extent={{-20,2},{22,-2}},
                          lineColor={255,204,51},
                          lineThickness=0.5)}));

        end LoadCtrlBus;
      end Interfaces;

    end Inverter;

    package Transformer

      package Model

        model MPZ
          parameter Modelica.SIunits.Voltage VHigh=208
            "Rms voltage on side 1 of the transformer (primary side)";
          parameter Modelica.SIunits.Voltage VLow=240
            "Rms voltage on side 2 of the transformer (secondary side)";
          parameter Modelica.SIunits.ApparentPower VABase=10e3
            "Nominal power of the transformer";
          parameter Real XoverR=3.01
            "Ratio between the complex and real components of the impedance (XL/R)";
          parameter Real Zperc=0.03 "Short circuit impedance";
          Buildings.Electrical.AC.ThreePhasesUnbalanced.Interfaces.Terminal_n mpz_head
            annotation (Placement(transformation(extent={{-110,-10},{-90,10}}),
                iconTransformation(extent={{-110,-10},{-90,10}})));
          Buildings.Electrical.AC.ThreePhasesUnbalanced.Interfaces.WyeToDelta delta_to_wye1
            "Delta to wye connection" annotation (Placement(transformation(extent={{-80,-10},
                    {-60,10}})));
          Buildings.Electrical.AC.ThreePhasesUnbalanced.Interfaces.Adapter3to3 ada_1
            annotation (Placement(transformation(extent={{-20,-10},{-40,10}})));
          Buildings.Electrical.AC.OnePhase.Conversion.ACACTransformer MPZ1(
            VHigh=VHigh,
            VLow=VLow,
            VABase=VABase,
            XoverR=XoverR,
            Zperc=Zperc)
            annotation (Placement(transformation(extent={{20,50},{40,70}})));
          Buildings.Electrical.AC.OnePhase.Conversion.ACACTransformer MPZ2(
            VHigh=VHigh,
            VLow=VLow,
            VABase=VABase,
            XoverR=XoverR,
            Zperc=Zperc)
            annotation (Placement(transformation(extent={{20,-10},{40,10}})));
          Buildings.Electrical.AC.OnePhase.Conversion.ACACTransformer MPZ3(
            VHigh=VHigh,
            VLow=VLow,
            VABase=VABase,
            XoverR=XoverR,
            Zperc=Zperc)
            annotation (Placement(transformation(extent={{20,-70},{40,-50}})));
          Buildings.Electrical.AC.OnePhase.Interfaces.Terminal_p inv_1
            annotation (Placement(transformation(extent={{110,50},{90,70}}),
                iconTransformation(extent={{110,50},{90,70}})));
          Buildings.Electrical.AC.OnePhase.Interfaces.Terminal_p inv_2
            annotation (Placement(transformation(extent={{110,-10},{90,10}}),
                iconTransformation(extent={{110,-10},{90,10}})));
          Buildings.Electrical.AC.OnePhase.Interfaces.Terminal_p inv_3
            annotation (Placement(transformation(extent={{110,-70},{90,-50}}),
                iconTransformation(extent={{110,-70},{90,-50}})));
          Sensor.Model.Probe3ph sens_dist_y
            annotation (Placement(transformation(extent={{-100,-10},{-80,10}})));
          Sensor.Model.Probe3ph sens_dist_d
            annotation (Placement(transformation(extent={{-60,-10},{-40,10}})));
          Buildings.Electrical.AC.OnePhase.Sensors.GeneralizedSensor sens_inv1
            annotation (Placement(transformation(
                extent={{10,10},{-10,-10}},
                rotation=180,
                origin={70,60})));
          Buildings.Electrical.AC.OnePhase.Sensors.GeneralizedSensor sens_inv2
            annotation (Placement(transformation(
                extent={{10,10},{-10,-10}},
                rotation=180,
                origin={70,0})));
          Buildings.Electrical.AC.OnePhase.Sensors.GeneralizedSensor sens_inv3
            annotation (Placement(transformation(
                extent={{10,10},{-10,-10}},
                rotation=180,
                origin={70,-60})));
          Buildings.Electrical.AC.OnePhase.Sensors.GeneralizedSensor sens_mpz1
            annotation (Placement(transformation(
                extent={{10,10},{-10,-10}},
                rotation=180,
                origin={0,60})));
          Buildings.Electrical.AC.OnePhase.Sensors.GeneralizedSensor sens_mpz2
            annotation (Placement(transformation(
                extent={{10,10},{-10,-10}},
                rotation=180,
                origin={0,0})));
          Buildings.Electrical.AC.OnePhase.Sensors.GeneralizedSensor sens_mpz3
            annotation (Placement(transformation(
                extent={{10,10},{-10,-10}},
                rotation=180,
                origin={0,-60})));
        equation
          connect(MPZ1.terminal_p, sens_inv1.terminal_n)
            annotation (Line(points={{40,60},{60,60}}, color={0,120,120}));
          connect(inv_1, sens_inv1.terminal_p)
            annotation (Line(points={{100,60},{100,60},{80,60}},color={0,120,120}));
          connect(inv_2, sens_inv2.terminal_p)
            annotation (Line(points={{100,0},{80,0},{80,0}}, color={0,120,120}));
          connect(inv_3, sens_inv3.terminal_p)
            annotation (Line(points={{100,-60},{100,-60},{80,-60}},color={0,120,120}));
          connect(sens_inv2.terminal_n, MPZ2.terminal_p)
            annotation (Line(points={{60,0},{40,0}}, color={0,120,120}));
          connect(sens_inv3.terminal_n, MPZ3.terminal_p)
            annotation (Line(points={{60,-60},{60,-60},{40,-60}}, color={0,120,120}));
          connect(sens_dist_y.terminal_n, mpz_head)
            annotation (Line(points={{-100,0},{-100,0}}, color={0,120,120}));
          connect(delta_to_wye1.wye, sens_dist_y.terminal_p)
            annotation (Line(points={{-80,0},{-80,0}}, color={0,120,120}));
          connect(delta_to_wye1.delta, sens_dist_d.terminal_n)
            annotation (Line(points={{-60,0},{-60,0}}, color={0,120,120}));
          connect(ada_1.terminal, sens_dist_d.terminal_p)
            annotation (Line(points={{-40,0},{-40,0}}, color={0,120,120}));
          connect(MPZ3.terminal_n, sens_mpz3.terminal_p)
            annotation (Line(points={{20,-60},{15,-60},{10,-60}}, color={0,120,120}));
          connect(MPZ2.terminal_n, sens_mpz2.terminal_p) annotation (Line(points={{20,0},
                  {14,0},{14,-1.33227e-015},{10,-1.33227e-015}}, color={0,120,120}));
          connect(MPZ1.terminal_n, sens_mpz1.terminal_p)
            annotation (Line(points={{20,60},{10,60}}, color={0,120,120}));
          connect(sens_mpz1.terminal_n, ada_1.terminals[1]) annotation (Line(points={{-10,60},
                  {-14,60},{-14,0.533333},{-20.2,0.533333}},     color={0,120,120}));
          connect(sens_mpz2.terminal_n, ada_1.terminals[2])
            annotation (Line(points={{-10,0},{-20.2,0}}, color={0,120,120}));
          connect(sens_mpz3.terminal_n, ada_1.terminals[3]) annotation (Line(points={{-10,-60},
                  {-14,-60},{-14,-0.533333},{-20.2,-0.533333}},      color={0,120,120}));
          annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
                coordinateSystem(preserveAspectRatio=false)));
        end MPZ;
      end Model;

      package Examples
        extends Modelica.Icons.ExamplesPackage;
        model Test_MPZ
          "Example to test the functionality of the Mini Power zone (MPZ) transformer."
          extends Modelica.Icons.Example;
          Model.MPZ MPZ_dist
            annotation (Placement(transformation(extent={{-20,-10},{0,10}})));
          Buildings.Electrical.AC.ThreePhasesUnbalanced.Sources.FixedVoltage sou(f=60,
              V=208)
            annotation (Placement(transformation(extent={{-100,-10},{-80,10}})));
          Sensor.Model.Probe3ph sens
            annotation (Placement(transformation(extent={{-60,-10},{-40,10}})));
          Buildings.Electrical.AC.OnePhase.Loads.Inductive load_inductive(pf=0.8,
              P_nominal=1000)
            annotation (Placement(transformation(extent={{60,-10},{80,10}})));
          Buildings.Electrical.AC.OnePhase.Loads.Resistive load_resistive(
              P_nominal=1000)
            annotation (Placement(transformation(extent={{60,40},{80,60}})));
          Buildings.Electrical.AC.OnePhase.Loads.Capacitive load_capacitive(pf=
                0.8, P_nominal=1000)
            annotation (Placement(transformation(extent={{60,-60},{80,-40}})));
          Buildings.Electrical.AC.OnePhase.Sensors.GeneralizedSensor
            sens_resistive
            annotation (Placement(transformation(extent={{20,40},{40,60}})));
          Buildings.Electrical.AC.OnePhase.Sensors.GeneralizedSensor
            sens_inductive
            annotation (Placement(transformation(extent={{20,-10},{40,10}})));
          Buildings.Electrical.AC.OnePhase.Sensors.GeneralizedSensor
            sens_capacitive
            annotation (Placement(transformation(extent={{20,-60},{40,-40}})));
        equation
          connect(sou.terminal, sens.terminal_n)
            annotation (Line(points={{-80,0},{-60,0}}, color={0,120,120}));
          connect(sens.terminal_p, MPZ_dist.mpz_head)
            annotation (Line(points={{-40,0},{-20,0}}, color={0,120,120}));
          connect(sens_resistive.terminal_p, load_resistive.terminal)
            annotation (Line(points={{40,50},{60,50}}, color={0,120,120}));
          connect(sens_capacitive.terminal_p, load_capacitive.terminal)
            annotation (Line(points={{40,-50},{60,-50}}, color={0,120,120}));
          connect(sens_inductive.terminal_p, load_inductive.terminal)
            annotation (Line(points={{40,0},{60,0}}, color={0,120,120}));
          connect(sens_inductive.terminal_n, MPZ_dist.inv_2)
            annotation (Line(points={{20,0},{0,0}}, color={0,120,120}));
          connect(sens_resistive.terminal_n, MPZ_dist.inv_1) annotation (Line(
                points={{20,50},{10,50},{10,6},{0,6}}, color={0,120,120}));
          connect(sens_capacitive.terminal_n, MPZ_dist.inv_3) annotation (Line(
                points={{20,-50},{12,-50},{12,-6},{0,-6}}, color={0,120,120}));
          annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
                coordinateSystem(preserveAspectRatio=false)));
        end Test_MPZ;
      end Examples;
    end Transformer;

    package Photovoltaics

      package Model

        model PVsimple
          parameter Real n(min=0, unit="1") = 14 "Number of PV modules";
          parameter Real A(min=0, unit="m2") = 1.65 "Net surface area per module";
          parameter Real eta(min=0, max=1, unit="1") = 0.15
            "Module conversion efficiency";
          Modelica.Blocks.Interfaces.RealInput G(min=0, unit="W/m2")
            "Total solar irradiation per unit area"
             annotation (Placement(transformation(
                origin={-120,0},
                extent={{20,20},{-20,-20}},
                rotation=180), iconTransformation(
                extent={{-20,-20},{20,20}},
                rotation=0,
                origin={-120,0})));
          Modelica.Blocks.Interfaces.RealOutput PV_generation "PV generation"
            annotation (Placement(transformation(extent={{100,-10},{120,10}})));
        equation
          PV_generation = A * n * eta * G;
        end PVsimple;

        model PVModule_simple
          parameter Real n(min=0, unit="1") = 14 "Number of PV modules";
          parameter Modelica.SIunits.Area A(min=0) = 1.65 "Net surface area per module [m2]";
          parameter Real eta(min=0, max=1, unit="1") = 0.158
            "Module conversion efficiency";
          parameter Real lat(unit="deg") = 37.9 "Latitude [deg]";
          parameter Real til(unit="deg") = 10 "Surface tilt [deg]";
          parameter Real azi(unit="deg") = 0 "Surface azimuth [deg] 0-S, 90-W, 180-N, 270-E ";
          Modelica.Blocks.Interfaces.RealInput scale(
            min=0,
            max=1,
            unit="1",
            start=1) "Shading of PV module" annotation (Placement(transformation(
                origin={-120,-40},
                extent={{20,20},{-20,-20}},
                rotation=180), iconTransformation(
                extent={{-20,-20},{20,20}},
                rotation=0,
                origin={-120,-40})));
          Buildings.BoundaryConditions.WeatherData.Bus
                          weaBus "Bus with weather data"
            annotation (Placement(transformation(extent={{-110,30},{-90,50}})));
          Modelica.Blocks.Interfaces.RealOutput P "PV generation in Watt"
            annotation (Placement(transformation(extent={{100,-10},{120,10}})));
          Solar.TiltedSolarWeabus tilted_Solar_TMY(
            til=til,
            lat=lat,
            azi=azi)
            annotation (Placement(transformation(extent={{-70,30},{-50,50}})));
          Model.PVsimple pV_simple(
            A=A,
            eta=eta,
            n=n) annotation (Placement(transformation(extent={{20,-10},{40,10}})));
          Modelica.Blocks.Math.Product product
            annotation (Placement(transformation(extent={{-20,-10},{0,10}})));
        equation
          connect(weaBus, tilted_Solar_TMY.weaBus) annotation (Line(
              points={{-100,40},{-70,40}},
              color={255,204,51},
              thickness=0.5), Text(
              string="%first",
              index=-1,
              extent={{-6,3},{-6,3}}));
          connect(product.u1, tilted_Solar_TMY.G) annotation (Line(points={{-22,6},{-40,
                  6},{-40,40},{-49,40}}, color={0,0,127}));
          connect(product.u2, scale) annotation (Line(points={{-22,-6},{-40,-6},{-40,-40},
                  {-120,-40}}, color={0,0,127}));
          connect(product.y, pV_simple.G)
            annotation (Line(points={{1,0},{18,0}}, color={0,0,127}));
          connect(pV_simple.PV_generation, P)
            annotation (Line(points={{41,0},{110,0}}, color={0,0,127}));
          annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
                coordinateSystem(preserveAspectRatio=false)));
        end PVModule_simple;

        model PVModule_simple_ZeroOrder
          parameter Real n(min=0, unit="1") = 14 "Number of PV modules";
          parameter Modelica.SIunits.Area A(min=0) = 1.65 "Net surface area per module [m2]";
          parameter Real eta(min=0, max=1, unit="1") = 0.158
            "Module conversion efficiency";
          parameter Real lat(unit="deg") = 37.9 "Latitude [deg]";
          parameter Real til(unit="deg") = 10 "Surface tilt [deg]";
          parameter Real azi(unit="deg") = 0 "Surface azimuth [deg] 0-S, 90-W, 180-N, 270-E ";
          parameter Real Ts(unit="s") = 60 "Time constant of zero order hold";
          Modelica.Blocks.Interfaces.RealInput scale(
            min=0,
            max=1,
            unit="1",
            start=1) "Shading of PV module" annotation (Placement(transformation(
                origin={-120,-40},
                extent={{20,20},{-20,-20}},
                rotation=180), iconTransformation(
                extent={{-20,-20},{20,20}},
                rotation=0,
                origin={-120,-40})));
          Buildings.BoundaryConditions.WeatherData.Bus
                          weaBus "Bus with weather data"
            annotation (Placement(transformation(extent={{-110,30},{-90,50}})));
          Modelica.Blocks.Interfaces.RealOutput P "PV generation in Watt"
            annotation (Placement(transformation(extent={{100,-10},{120,10}})));
          Solar.TiltedSolarWeabus tilted_Solar_TMY(
            til=til,
            lat=lat,
            azi=azi)
            annotation (Placement(transformation(extent={{-70,30},{-50,50}})));
          Model.PVsimple pV_simple(
            A=A,
            eta=eta,
            n=n) annotation (Placement(transformation(extent={{20,-10},{40,10}})));
          Modelica.Blocks.Math.Product product
            annotation (Placement(transformation(extent={{-20,-10},{0,10}})));
          Modelica.Blocks.Discrete.ZeroOrderHold zeroOrderHold_Pv(samplePeriod=Ts)
            annotation (Placement(transformation(
                extent={{-10,-10},{10,10}},
                rotation=-90,
                origin={-40,20})));
        equation
          connect(weaBus, tilted_Solar_TMY.weaBus) annotation (Line(
              points={{-100,40},{-70,40}},
              color={255,204,51},
              thickness=0.5), Text(
              string="%first",
              index=-1,
              extent={{-6,3},{-6,3}}));
          connect(product.u2, scale) annotation (Line(points={{-22,-6},{-40,-6},{-40,-40},
                  {-120,-40}}, color={0,0,127}));
          connect(product.y, pV_simple.G)
            annotation (Line(points={{1,0},{18,0}}, color={0,0,127}));
          connect(pV_simple.PV_generation, P)
            annotation (Line(points={{41,0},{110,0}}, color={0,0,127}));
          connect(product.u1, zeroOrderHold_Pv.y)
            annotation (Line(points={{-22,6},{-40,6},{-40,9}}, color={0,0,127}));
          connect(zeroOrderHold_Pv.u, tilted_Solar_TMY.G)
            annotation (Line(points={{-40,32},{-40,40},{-49,40}}, color={0,0,127}));
          annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
                coordinateSystem(preserveAspectRatio=false)));
        end PVModule_simple_ZeroOrder;

        model PVandWeather_simple_ZeroOrder
          // Weather data
          parameter String weather_file = "" "Path to weather file";
          // PV generation
          parameter Real n(min=0, unit="1") = 26 "Number of PV modules";
          parameter Real A(min=0, unit="m2") = 1.65 "Net surface area per module";
          parameter Real eta(min=0, max=1, unit="1") = 0.158
            "Module conversion efficiency";
          parameter Real lat(unit="deg") = 37.9 "Latitude";
          parameter Real til(unit="deg") = 10 "Surface tilt";
          parameter Real azi(unit="deg") = 0 "Surface azimuth 0-S, 90-W, 180-N, 270-E ";
          parameter Real Ts(unit="s") = 5*60 "Time constant of zero order hold";

          SCooDER.Components.Photovoltaics.Model.PVModule_simple_ZeroOrder
            pVModule_simple_ZeroOrder(
            n=n,
            A=A,
            eta=eta,
            lat=lat,
            til=til,
            azi=azi,
            Ts=Ts)
            annotation (Placement(transformation(extent={{-10,40},{10,60}})));
          Buildings.BoundaryConditions.WeatherData.ReaderTMY3 weaDatInpCon(
              computeWetBulbTemperature=false, filNam=weather_file)
            "Weather data reader with radiation data obtained from the inputs' connectors"
            annotation (Placement(transformation(extent={{-80,60},{-60,80}})));
          Modelica.Blocks.Interfaces.RealInput scale(start=1, unit="1")
            annotation (Placement(transformation(extent={{-140,-20},{-100,20}})));
          Modelica.Blocks.Interfaces.RealOutput P_kw(unit="kW", start=0)
            "Active power"
            annotation (Placement(transformation(extent={{100,0},{120,20}})));
          Modelica.Blocks.Math.Gain WtokW(k=1/1e3)
            annotation (Placement(transformation(extent={{20,0},{40,20}})));
          Modelica.Blocks.Interfaces.RealOutput P(start=0, unit="W")
            "Active power"
            annotation (Placement(transformation(extent={{100,40},{120,60}})));
        equation
          connect(weaDatInpCon.weaBus, pVModule_simple_ZeroOrder.weaBus)
            annotation (Line(
              points={{-60,70},{-40,70},{-40,54},{-10,54}},
              color={255,204,51},
              thickness=0.5));
          connect(pVModule_simple_ZeroOrder.P, WtokW.u)
            annotation (Line(points={{11,50},{14,50},{14,10},{18,10}},
                                                       color={0,0,127}));
          connect(pVModule_simple_ZeroOrder.scale, scale) annotation (Line(points={{-12,
                  46},{-40,46},{-40,0},{-120,0}}, color={0,0,127}));
          connect(WtokW.y, P_kw)
            annotation (Line(points={{41,10},{110,10}}, color={0,0,127}));
          connect(pVModule_simple_ZeroOrder.P, P)
            annotation (Line(points={{11,50},{110,50}}, color={0,0,127}));
          annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
                coordinateSystem(preserveAspectRatio=false)));
        end PVandWeather_simple_ZeroOrder;

        model PVandWeather_simple
          // Weather data
          parameter String weather_file = "" "Path to weather file";
          // PV generation
          parameter Real n(min=0, unit="1") = 26 "Number of PV modules";
          parameter Real A(min=0, unit="m2") = 1.65 "Net surface area per module";
          parameter Real eta(min=0, max=1, unit="1") = 0.158
            "Module conversion efficiency";
          parameter Real lat(unit="deg") = 37.9 "Latitude";
          parameter Real til(unit="deg") = 10 "Surface tilt";
          parameter Real azi(unit="deg") = 0 "Surface azimuth 0-S, 90-W, 180-N, 270-E ";

          PVModule_simple pVModule_simple(
            n=n,
            A=A,
            eta=eta,
            lat=lat,
            til=til,
            azi=azi) annotation (Placement(transformation(extent={{-10,40},{10,60}})));
          Buildings.BoundaryConditions.WeatherData.ReaderTMY3 weaDatInpCon(
              computeWetBulbTemperature=false, filNam=weather_file)
            "Weather data reader with radiation data obtained from the inputs' connectors"
            annotation (Placement(transformation(extent={{-80,60},{-60,80}})));
          Modelica.Blocks.Interfaces.RealInput scale(start=1, unit="1")
            annotation (Placement(transformation(extent={{-140,-20},{-100,20}})));
          Modelica.Blocks.Math.Gain WtokW(k=1/1e3)
            annotation (Placement(transformation(extent={{20,0},{40,20}})));
          Modelica.Blocks.Interfaces.RealOutput P_kw(unit="kW", start=0)
            "Active power"
            annotation (Placement(transformation(extent={{100,0},{120,20}})));
          Modelica.Blocks.Interfaces.RealOutput P(start=0, unit="W")
            "Active power"
            annotation (Placement(transformation(extent={{100,40},{120,60}})));
        equation
          connect(weaDatInpCon.weaBus, pVModule_simple.weaBus) annotation (Line(
              points={{-60,70},{-40,70},{-40,54},{-10,54}},
              color={255,204,51},
              thickness=0.5));
          connect(pVModule_simple.scale, scale) annotation (Line(points={{-12,46},{-40,46},
                  {-40,0},{-120,0}}, color={0,0,127}));
          connect(WtokW.y, P_kw)
            annotation (Line(points={{41,10},{110,10}}, color={0,0,127}));
          connect(pVModule_simple.P, P)
            annotation (Line(points={{11,50},{110,50}}, color={0,0,127}));
          connect(WtokW.u, pVModule_simple.P) annotation (Line(points={{18,10},
                  {14,10},{14,50},{11,50}}, color={0,0,127}));
          annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
                coordinateSystem(preserveAspectRatio=false)));
        end PVandWeather_simple;

        model PVandWeatherExt_simple
          // Weather data
          parameter String weather_file = "" "Path to weather file";
          // PV generation
          parameter Real n(min=0, unit="1") = 26 "Number of PV modules";
          parameter Real A(min=0, unit="m2") = 1.65 "Net surface area per module";
          parameter Real eta(min=0, max=1, unit="1") = 0.158
            "Module conversion efficiency";
          parameter Real lat(unit="deg") = 37.9 "Latitude";
          parameter Real til(unit="deg") = 10 "Surface tilt";
          parameter Real azi(unit="deg") = 0 "Surface azimuth 0-S, 90-W, 180-N, 270-E ";

          PVModule_simple pVModule_simple(
            n=n,
            A=A,
            eta=eta,
            lat=lat,
            til=til,
            azi=azi) annotation (Placement(transformation(extent={{-10,40},{10,60}})));
          Buildings.BoundaryConditions.WeatherData.ReaderTMY3 weaDatInpCon(
              computeWetBulbTemperature=false, filNam=weather_file,
            HSou=Buildings.BoundaryConditions.Types.RadiationDataSource.Input_HGloHor_HDifHor)
            "Weather data reader with radiation data obtained from the inputs' connectors"
            annotation (Placement(transformation(extent={{-80,60},{-60,80}})));
          Modelica.Blocks.Interfaces.RealInput scale(start=1, unit="1")
            annotation (Placement(transformation(extent={{-140,-20},{-100,20}})));
          Modelica.Blocks.Interfaces.RealInput DHI(unit="W/m2", start=0)
            annotation (Placement(transformation(extent={{-140,60},{-100,100}})));
          Modelica.Blocks.Interfaces.RealInput GHI(unit="W/m2", start=0)
            annotation (Placement(transformation(extent={{-140,30},{-100,70}})));
          Modelica.Blocks.Math.Gain WtokW(k=1/1e3)
            annotation (Placement(transformation(extent={{20,0},{40,20}})));
          Modelica.Blocks.Interfaces.RealOutput P_kw(unit="kW", start=0)
            "Active power"
            annotation (Placement(transformation(extent={{100,0},{120,20}})));
          Modelica.Blocks.Interfaces.RealOutput P(start=0, unit="W")
            "Active power"
            annotation (Placement(transformation(extent={{100,40},{120,60}})));
        equation
          connect(weaDatInpCon.weaBus, pVModule_simple.weaBus) annotation (Line(
              points={{-60,70},{-40,70},{-40,54},{-10,54}},
              color={255,204,51},
              thickness=0.5));
          connect(pVModule_simple.scale, scale) annotation (Line(points={{-12,46},{-40,46},
                  {-40,0},{-120,0}}, color={0,0,127}));
          connect(weaDatInpCon.HDifHor_in, DHI) annotation (Line(points={{-81,
                  62.4},{-90,62.4},{-90,80},{-120,80}}, color={0,0,127}));
          connect(weaDatInpCon.HGloHor_in, GHI) annotation (Line(points={{-81,
                  57},{-90,57},{-90,50},{-120,50}}, color={0,0,127}));
          connect(WtokW.y, P_kw)
            annotation (Line(points={{41,10},{110,10}}, color={0,0,127}));
          connect(P, pVModule_simple.P)
            annotation (Line(points={{110,50},{11,50}}, color={0,0,127}));
          connect(WtokW.u, pVModule_simple.P) annotation (Line(points={{18,10},
                  {14,10},{14,50},{11,50}}, color={0,0,127}));
          annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
                coordinateSystem(preserveAspectRatio=false)));
        end PVandWeatherExt_simple;
      end Model;

      package Examples
        extends Modelica.Icons.ExamplesPackage;

        model Comparisons
          "PV module comparisons between simplified, Buildings library and Diode model (TGM library)."
          extends Modelica.Icons.Example;

          Buildings.BoundaryConditions.WeatherData.ReaderTMY3 weaDatInpCon(
            filNam="C:/Users/Christoph/Documents/Buildings 4.0.0/Resources/weatherdata/USA_CA_San.Francisco.Intl.AP.724940_TMY3.mos",
            computeWetBulbTemperature=false)
            "Weather data reader with radiation data obtained from the inputs' connectors"
            annotation (Placement(transformation(extent={{-80,50},{-60,70}})));
          Model.PVModule_simple pVModule_simple(til=45)
            annotation (Placement(transformation(extent={{-20,20},{0,40}})));
          Buildings.Electrical.AC.OnePhase.Sources.PVSimpleOriented pv180deg(
            fAct=1,
            pf=1,
            eta_DCAC=1,
            V_nominal=120,
            eta=0.15,
            A=23.1,
            til=0.78539816339745,
            lat=0.66147978650585,
            azi=3.1415926535898)
            annotation (Placement(transformation(extent={{-20,-20},{0,0}})));
          Buildings.Electrical.AC.OnePhase.Sources.FixedVoltage source(f=60, V=120)
            annotation (Placement(transformation(extent={{-80,-20},{-60,0}})));
          Modelica.Blocks.Sources.Constant const(k=1)
            annotation (Placement(transformation(extent={{-80,20},{-60,40}})));
          Buildings.Electrical.AC.OnePhase.Sources.PVSimpleOriented pv0deg(
            fAct=1,
            pf=1,
            eta_DCAC=1,
            V_nominal=120,
            azi=0,
            A=23.1,
            eta=0.15,
            til=0.78539816339745,
            lat=0.66147978650585)
            annotation (Placement(transformation(extent={{-20,-50},{0,-30}})));
          Buildings.Electrical.AC.OnePhase.Sources.PVSimpleOriented pv90deg(
            fAct=1,
            pf=1,
            eta_DCAC=1,
            V_nominal=120,
            eta=0.15,
            A=23.1,
            til=0.78539816339745,
            lat=0.66147978650585,
            azi=1.5707963267949)
            annotation (Placement(transformation(extent={{-20,-80},{0,-60}})));
        equation
          connect(pVModule_simple.weaBus, weaDatInpCon.weaBus) annotation (Line(
              points={{-20,34},{-40,34},{-40,60},{-60,60}},
              color={255,204,51},
              thickness=0.5));
          connect(pv180deg.weaBus, weaDatInpCon.weaBus) annotation (Line(
              points={{-10,-1},{-40,-1},{-40,60},{-60,60}},
              color={255,204,51},
              thickness=0.5));
          connect(source.terminal, pv180deg.terminal)
            annotation (Line(points={{-60,-10},{-20,-10}}, color={0,120,120}));
          connect(const.y, pVModule_simple.scale) annotation (Line(points={{-59,30},{-50,
                  30},{-50,26},{-22,26}}, color={0,0,127}));
          connect(source.terminal, pv0deg.terminal) annotation (Line(points={{-60,
                  -10},{-50,-10},{-50,-40},{-20,-40}}, color={0,120,120}));
          connect(source.terminal, pv90deg.terminal) annotation (Line(points={{
                  -60,-10},{-50,-10},{-50,-70},{-20,-70}}, color={0,120,120}));
          connect(pv0deg.weaBus, weaDatInpCon.weaBus) annotation (Line(
              points={{-10,-31},{-26,-31},{-40,-31},{-40,-32},{-40,0},{-40,60},{-60,60}},
              color={255,204,51},
              thickness=0.5));
          connect(pv90deg.weaBus, weaDatInpCon.weaBus) annotation (Line(
              points={{-10,-61},{-40,-61},{-40,0},{-40,60},{-60,60}},
              color={255,204,51},
              thickness=0.5));
          annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
                coordinateSystem(preserveAspectRatio=false)));
        end Comparisons;

        model Annual_Flexgrid
            extends Modelica.Icons.Example;
          Model.PVModule_simple Single_flexgrid
            annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
          Buildings.BoundaryConditions.WeatherData.ReaderTMY3 weaDatInpCon1(
              computeWetBulbTemperature=false, filNam="C:/Users/Christoph/Documents/SmartInverter/smartinverter_simulation/ExampleData/USA_CA_San.Francisco.Intl.AP.724940_TMY3.mos")
            "Weather data reader with radiation data obtained from the inputs' connectors"
            annotation (Placement(transformation(extent={{-80,60},{-60,80}})));
          Modelica.Blocks.Sources.Constant shade(k=1)
            annotation (Placement(transformation(extent={{-80,-30},{-60,-10}})));
          Modelica.Blocks.Math.Gain Full_Flexgrid(k=3)
            annotation (Placement(transformation(extent={{40,20},{60,40}})));
        equation
          connect(weaDatInpCon1.weaBus, Single_flexgrid.weaBus) annotation (Line(
              points={{-60,70},{-40,70},{-40,4},{-10,4}},
              color={255,204,51},
              thickness=0.5));
          connect(Single_flexgrid.scale, shade.y) annotation (Line(points={{-12,-4},{
                  -40,-4},{-40,-20},{-59,-20}},
                                            color={0,0,127}));
          connect(Full_Flexgrid.u, Single_flexgrid.P)
            annotation (Line(points={{38,30},{20,30},{20,0},{11,0}}, color={0,0,127}));
          annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
                coordinateSystem(preserveAspectRatio=false)));
        end Annual_Flexgrid;

        model Test_PVandWeatherExt_simple
          extends Modelica.Icons.Example;

          Model.PVandWeatherExt_simple PV(weather_file=
                "C:/Users/Christoph/Documents/SmartInverter/smartinverter_simulation/ExampleData/USA_CA_San.Francisco.Intl.AP.724940_TMY3.mos")
            annotation (Placement(transformation(extent={{40,-8},{60,12}})));
          Modelica.Blocks.Sources.Constant curtail(k=1)
            annotation (Placement(transformation(extent={{-60,-20},{-40,0}})));
          Modelica.Blocks.Sources.Sine ghi(amplitude=900, freqHz=1/(60*60*24))
            annotation (Placement(transformation(extent={{-60,20},{-40,40}})));
          Modelica.Blocks.Math.Gain dhi(k=0.2)
            annotation (Placement(transformation(extent={{-20,20},{0,40}})));
        equation
          connect(PV.scale, curtail.y) annotation (Line(points={{38,2},{-30,2},
                  {-30,-10},{-39,-10}}, color={0,0,127}));
          connect(dhi.u, ghi.y)
            annotation (Line(points={{-22,30},{-39,30}}, color={0,0,127}));
          connect(PV.GHI, ghi.y) annotation (Line(points={{38,7},{-30,7},{-30,
                  30},{-39,30}}, color={0,0,127}));
          connect(dhi.y, PV.DHI) annotation (Line(points={{1,30},{18,30},{18,10},
                  {38,10}}, color={0,0,127}));
          annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
                coordinateSystem(preserveAspectRatio=false)));
        end Test_PVandWeatherExt_simple;
      end Examples;
    end Photovoltaics;

    package Battery

      package Model

        model Battery
          parameter Real EMax(min=0) = 6400
            "Battery Capacity [Wh]";
          parameter Real Pmax(min=0) = 3300
            "Battery Power [W]";
          parameter Real SOC_start(min=0, max=1, unit="1") = 0.1
            "Initial SOC value";
          parameter Real SOC_min(min=0, max=1, unit="1") = 0.1
            "Minimum SOC value";
          parameter Real SOC_max(min=0, max=1, unit="1") = 1
            "Maximum SOC value";
          parameter Real etaCha(min=0, max=1, unit="1") = 0.96
            "Charging efficiency";
          parameter Real etaDis(min=0, max=1, unit="1") = 0.96
            "Discharging efficiency";
          Real p_batt_eff;
         Modelica.Blocks.Interfaces.RealInput P_ctrl(unit="W")
            "Power control to charge (positive) discharge (negativ) the battery"
            annotation (Placement(transformation(
                extent={{-20,-20},{20,20}},
                rotation=0,
                origin={-120,0}), iconTransformation(
                extent={{-20,-20},{20,20}},
                rotation=0,
                origin={-120,0})));
          Modelica.Blocks.Interfaces.RealOutput SOC "State of Charge [-]"
            annotation (Placement(transformation(extent={{100,70},{120,90}})));
          Modelica.Blocks.Interfaces.RealOutput P_batt "Power demand Battery"
            annotation (Placement(transformation(extent={{100,-10},{120,10}})));
          Buildings.Electrical.DC.Storage.BaseClasses.Charge soc_model(
            etaCha=etaCha,
            etaDis=etaDis,
            SOC_start=SOC_start,
            EMax=EMax*3600) "Charge model"
            annotation (Placement(transformation(extent={{20,70},{40,90}})));
          Modelica.Blocks.Interfaces.RealOutput SOE "State of Energy [Wh]"
            annotation (Placement(transformation(extent={{100,40},{120,60}})));
          Modelica.Blocks.Sources.RealExpression soe_calc(y=soc_model.SOC*EMax)
            annotation (Placement(transformation(extent={{20,40},{40,60}})));
          Modelica.Blocks.Sources.RealExpression power_calc(y=p_batt_eff)
            annotation (Placement(transformation(extent={{-20,70},{0,90}})));
        equation
          if (soc_model.SOC>=SOC_min) and (soc_model.SOC<=SOC_max) then
            if (P_batt<0) then
              P_batt = max(Pmax*(-1), P_ctrl);
            else
              P_batt = min(Pmax, P_ctrl);
            end if;
          else
            if (P_ctrl<0) and (soc_model.SOC>SOC_min) then
              P_batt = max(Pmax*(-1), P_ctrl);
            elseif (P_ctrl>0) and (soc_model.SOC<SOC_max) then
              P_batt = min(Pmax, P_ctrl);
            else
              P_batt = 0;
            end if;
          end if;
          p_batt_eff = if (P_batt > 0) then P_batt*etaCha else P_batt*(1/etaDis);

          connect(soc_model.SOC, SOC) annotation (Line(
              points={{41,80},{110,80}},
              color={0,0,127},
              smooth=Smooth.None));
          connect(soe_calc.y, SOE)
            annotation (Line(points={{41,50},{110,50}}, color={0,0,127}));
          connect(power_calc.y, soc_model.P)
            annotation (Line(points={{1,80},{18,80}}, color={0,0,127}));
          annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
                coordinateSystem(preserveAspectRatio=false)));
        end Battery;
      end Model;

      package Examples
        extends Modelica.Icons.ExamplesPackage;

        model Test_Battery

          Model.Battery battery
            annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
          Modelica.Blocks.Sources.Sine BatteryPower(
            phase=0,
            offset=0,
            freqHz=1/(60*60*12),
            amplitude=2500)
            annotation (Placement(transformation(extent={{-60,-10},{-40,10}})));
        equation
          connect(BatteryPower.y, battery.P_ctrl)
            annotation (Line(points={{-39,0},{-12,0}}, color={0,0,127}));
          annotation (Icon(coordinateSystem(preserveAspectRatio=false)),
          experiment(StopTime=86400),
              Diagram(
                coordinateSystem(preserveAspectRatio=false)));
        end Test_Battery;
      end Examples;
    end Battery;

    package Controller

      package Model

        model voltvar

          Modelica.Blocks.Interfaces.RealInput v_pu( start=1, unit="1") "Voltage [p.u.]" annotation (Placement(transformation(extent={{-140,-20},{-100,20}})));
          Modelica.Blocks.Interfaces.RealOutput q_control( start=0, unit="var") "Q control signal" annotation (Placement(transformation(extent={{100,-10},{120,10}})));
          Modelica.Blocks.Interfaces.RealInput v_max( start=1.05, unit="1") "Voltage maximum [p.u.]" annotation (Placement(transformation(extent={{-140,60},{-100,100}})));
          Modelica.Blocks.Interfaces.RealInput v_maxdead( start=1.01, unit="1") "Upper bound of deadband [p.u.]" annotation (Placement(transformation(extent={{-140,20},{-100,60}})));
          Modelica.Blocks.Interfaces.RealInput v_mindead( start=0.99, unit="1") "Upper bound of deadband [p.u.]" annotation (Placement(transformation(extent={{-140,-60},{-100,-20}})));
          Modelica.Blocks.Interfaces.RealInput v_min( start=0.95, unit="1") "Voltage minimum [p.u.]" annotation (Placement(transformation(extent={{-140,-100},{-100,-60}})));
          Modelica.Blocks.Interfaces.RealInput q_maxind( start=1000, unit="var") "Maximal Reactive Power (Inductive)" annotation (
              Placement(transformation(
                extent={{-20,-20},{20,20}},
                rotation=270,
                origin={20,120})));
          Modelica.Blocks.Interfaces.RealInput q_maxcap( start=1000, unit="var") "Maximal Reactive Power (Capacitive)" annotation (
              Placement(transformation(
                extent={{-20,-20},{20,20}},
                rotation=270,
                origin={-40,120})));
        equation
          q_control = smooth(0,
            if v_pu > v_max then q_maxind * (-1)
            elseif v_pu > v_maxdead then (v_maxdead - v_pu)/abs(v_max - v_maxdead) * q_maxind
            elseif v_pu < v_min then q_maxcap
            elseif v_pu < v_mindead then (v_mindead - v_pu)/abs(v_min - v_mindead) * q_maxcap
            else 0);

        end voltvar;

        model voltvar_param
          parameter Real v_max( start=1.05, unit="1")=1.05 "Voltage maximum [p.u.]";
          parameter Real v_maxdead( start=1.01, unit="1")=1.01 "Upper bound of deadband [p.u.]";
          parameter Real v_mindead( start=0.99, unit="1")=0.99 "Lower bound of deadband [p.u.]";
          parameter Real v_min( start=0.95, unit="1")=0.95 "Voltage minimum [p.u.]";
          parameter Real q_maxind( start=1000, unit="var")=1000 "Maximal Reactive Power (Inductive) [var]";
          parameter Real q_maxcap( start=1000, unit="var")=1000 "Maximal Reactive Power (Capacitive) [var]";

          SCooDER.Components.Controller.Model.voltvar voltvar
            annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
          Modelica.Blocks.Sources.RealExpression Param1(y=v_max) annotation (Placement(transformation(extent={{-62,30},
                    {-42,50}})));
          Modelica.Blocks.Sources.RealExpression Param2(y=v_maxdead) annotation (Placement(transformation(extent={{-62,10},
                    {-42,30}})));
          Modelica.Blocks.Sources.RealExpression Param3(y=v_mindead) annotation (Placement(transformation(extent={{-62,-30},
                    {-42,-10}})));
          Modelica.Blocks.Sources.RealExpression Param4(y=v_min) annotation (Placement(transformation(extent={{-62,-50},
                    {-42,-30}})));
          Modelica.Blocks.Sources.RealExpression Param5(y=q_maxcap) annotation (
              Placement(transformation(
                extent={{-10,-10},{10,10}},
                rotation=-90,
                origin={-4,50})));
          Modelica.Blocks.Sources.RealExpression Param6(y=q_maxind) annotation (
              Placement(transformation(
                extent={{-10,-10},{10,10}},
                rotation=-90,
                origin={14,50})));
          Modelica.Blocks.Interfaces.RealOutput qctrl(unit="var", start=0)
            "Q control signal"
            annotation (Placement(transformation(extent={{100,-10},{120,10}})));
          Modelica.Blocks.Interfaces.RealInput v_pu(start=1, unit="1") "Voltage [p.u.]" annotation (Placement(transformation(extent={{-140,
                    -20},{-100,20}})));
        equation
          connect(Param1.y, voltvar.v_max) annotation (Line(points={{-41,40},{-22,40},{
                  -22,8},{-12,8}},
                               color={0,0,127}));
          connect(Param2.y, voltvar.v_maxdead) annotation (Line(points={{-41,20},{-26,
                  20},{-26,4},{-12,4}},
                                    color={0,0,127}));
          connect(Param3.y, voltvar.v_mindead) annotation (Line(points={{-41,-20},{-26,
                  -20},{-26,-4},{-12,-4}},
                                      color={0,0,127}));
          connect(voltvar.v_min, Param4.y) annotation (Line(points={{-12,-8},{-22,-8},{
                  -22,-40},{-41,-40}},
                                   color={0,0,127}));
          connect(Param5.y, voltvar.q_maxcap)
            annotation (Line(points={{-4,39},{-4,25.5},{-4,12}},    color={0,0,127}));
          connect(Param6.y, voltvar.q_maxind) annotation (Line(points={{14,39},{14,39},
                  {14,20},{2,20},{2,12}},    color={0,0,127}));
          connect(voltvar.v_pu, v_pu) annotation (Line(points={{-12,0},{-120,0}},
                               color={0,0,127}));
          connect(voltvar.q_control, qctrl)
            annotation (Line(points={{11,0},{110,0},{110,0}}, color={0,0,127}));
          annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
                coordinateSystem(preserveAspectRatio=false)));
        end voltvar_param;

        model voltvar_param_bus
          parameter Real V_nominal(min=0, unit="V") = 120 "Nominal sytem voltage to scale Vp.u.";
          parameter Real v_max( start=1.05, unit="1")=1.05 "Voltage maximum [p.u.]";
          parameter Real v_maxdead( start=1.01, unit="1")=1.01 "Upper bound of deadband [p.u.]";
          parameter Real v_mindead( start=0.99, unit="1")=0.99 "Lower bound of deadband [p.u.]";
          parameter Real v_min( start=0.95, unit="1")=0.95 "Voltage minimum [p.u.]";
          parameter Real q_maxind( start=1000, unit="var")=1000 "Maximal Reactive Power (Inductive) [var]";
          parameter Real q_maxcap( start=1000, unit="var")=1000 "Maximal Reactive Power (Capacitive) [var]";
          voltvar_param voltvar(
            v_max=v_max,
            v_maxdead=v_maxdead,
            v_mindead=v_mindead,
            v_min=v_min,
            q_maxind=q_maxind,
            q_maxcap=q_maxcap)
            annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
          Inverter.Interfaces.InvCtrlBus invCtrlBus annotation (Placement(
                transformation(extent={{80,-20},{120,20}}), iconTransformation(extent={{
                    90,-10},{110,10}})));
          Modelica.Blocks.Math.Gain voltageScale(k=1/V_nominal)
            annotation (Placement(transformation(extent={{-52,-10},{-32,10}})));
        equation
          connect(voltageScale.y, voltvar.v_pu)
            annotation (Line(points={{-31,0},{-12,0}},            color={0,0,127}));
          connect(voltageScale.u, invCtrlBus.v) annotation (Line(points={{-54,0},{-60,0},
                  {-60,30},{60,30},{60,0.1},{100.1,0.1}}, color={0,0,127}), Text(
              string="%second",
              index=1,
              extent={{6,3},{6,3}}));
          connect(voltvar.qctrl, invCtrlBus.qctrl) annotation (Line(points={{11,0},{
                  100.1,0},{100.1,0.1}}, color={0,0,127}), Text(
              string="%second",
              index=1,
              extent={{6,3},{6,3}}));
          annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
                coordinateSystem(preserveAspectRatio=false)));
        end voltvar_param_bus;

        model voltvar_param_pf
          parameter Real v_max( start=1.05, unit="1")=1.05 "Voltage maximum [p.u.]";
          parameter Real v_maxdead( start=1.01, unit="1")=1.01 "Upper bound of deadband [p.u.]";
          parameter Real v_mindead( start=0.99, unit="1")=0.99 "Lower bound of deadband [p.u.]";
          parameter Real v_min( start=0.95, unit="1")=0.95 "Voltage minimum [p.u.]";
          parameter Real q_maxind( start=1000, unit="var")=1000 "Maximal Reactive Power (Inductive) [var]";
          parameter Real q_maxcap( start=1000, unit="var")=1000 "Maximal Reactive Power (Capacitive) [var]";

          Utility.QToPf qToPf annotation (Placement(transformation(extent={{10,-10},{30,10}})));
          SCooDER.Components.Controller.Model.voltvar voltvar
            annotation (Placement(transformation(extent={{-28,-10},{-8,10}})));
          Modelica.Blocks.Sources.RealExpression Param1(y=v_max) annotation (Placement(transformation(extent={{-80,30},{-60,50}})));
          Modelica.Blocks.Sources.RealExpression Param2(y=v_maxdead) annotation (Placement(transformation(extent={{-80,10},{-60,30}})));
          Modelica.Blocks.Sources.RealExpression Param3(y=v_mindead) annotation (Placement(transformation(extent={{-80,-30},{-60,-10}})));
          Modelica.Blocks.Sources.RealExpression Param4(y=v_min) annotation (Placement(transformation(extent={{-80,-50},{-60,-30}})));
          Modelica.Blocks.Sources.RealExpression Param5(y=q_maxcap) annotation (
              Placement(transformation(
                extent={{-10,-10},{10,10}},
                rotation=-90,
                origin={-22,50})));
          Modelica.Blocks.Sources.RealExpression Param6(y=q_maxind) annotation (
              Placement(transformation(
                extent={{-10,-10},{10,10}},
                rotation=-90,
                origin={-4,50})));
          Modelica.Blocks.Interfaces.RealOutput pf( start=1, unit="1")
            "pf control signal"                                                            annotation (Placement(transformation(extent={{100,-10},{120,10}})));
          Modelica.Blocks.Interfaces.RealInput p(start=0, unit="W") "active power [W]" annotation (Placement(transformation(
                extent={{-20,-20},{20,20}},
                rotation=0,
                origin={-120,50})));
          Modelica.Blocks.Interfaces.RealInput v_pu(start=1, unit="1") "Voltage [p.u.]" annotation (Placement(transformation(extent={{-140,-70},{-100,-30}})));
        equation
          connect(voltvar.q_control, qToPf.q)
            annotation (Line(points={{-7,0},{0.5,0},{8,0}}, color={0,0,127}));
          connect(Param1.y, voltvar.v_max) annotation (Line(points={{-59,40},{-40,40},{-40,
                  8},{-30,8}}, color={0,0,127}));
          connect(Param2.y, voltvar.v_maxdead) annotation (Line(points={{-59,20},{-44,20},
                  {-44,4},{-30,4}}, color={0,0,127}));
          connect(Param3.y, voltvar.v_mindead) annotation (Line(points={{-59,-20},{-44,-20},
                  {-44,-4},{-30,-4}}, color={0,0,127}));
          connect(voltvar.v_min, Param4.y) annotation (Line(points={{-30,-8},{-40,-8},{-40,
                  -40},{-59,-40}}, color={0,0,127}));
          connect(Param5.y, voltvar.q_maxcap)
            annotation (Line(points={{-22,39},{-22,25.5},{-22,12}}, color={0,0,127}));
          connect(Param6.y, voltvar.q_maxind) annotation (Line(points={{-4,39},{-4,39},{
                  -4,20},{-16,20},{-16,12}}, color={0,0,127}));
          connect(voltvar.v_pu, v_pu) annotation (Line(points={{-30,0},{-90,0},{-90,-50},
                  {-120,-50}}, color={0,0,127}));
          connect(p, qToPf.p) annotation (Line(points={{-120,50},{-90,50},{-90,80},{20,
                  80},{20,14},{20,12}},             color={0,0,127}));
          connect(qToPf.pf, pf)
            annotation (Line(points={{31,0},{110,0}},         color={0,0,127}));
          annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
                coordinateSystem(preserveAspectRatio=false)));
        end voltvar_param_pf;

        model voltVar_param_simple

          Modelica.Blocks.Interfaces.RealInput v(start = 1, unit="1") "Voltage [p.u]"
            annotation (Placement(transformation(extent={{-140,-20},{-100,20}})));
          Modelica.Blocks.Interfaces.RealOutput QCon(start= 0, unit="var") "Q control signal"
            annotation (Placement(transformation(extent={{100,-10},{120,10}})));
          parameter Real thr = 0.05 "over/undervoltage threshold";
          parameter Real hys = 0.01 "Hysteresis";
          final parameter Modelica.SIunits.PerUnit vMaxDea=1 + hys "Upper bound of deaband [p.u.]";
          final parameter Modelica.SIunits.PerUnit vMax=1 + thr "Voltage maximum [p.u.]";
          final parameter Modelica.SIunits.PerUnit vMinDea=1 - hys "Upper bound of deaband [p.u.]";
          final parameter Modelica.SIunits.PerUnit vMin=1 - thr "Voltage minimum [p.u.]";
          parameter Real QMaxInd(unit="var") = 1000 "Maximal Reactive Power (Inductive)";
          parameter Real QMaxCap(unit="var") = 1000 "Maximal Reactive Power (Capacitive)";
        equation
          QCon = smooth(0, if v > vMax then QMaxInd*(-1) elseif v > vMaxDea then (vMaxDea - v)/
            abs(vMax - vMaxDea)*QMaxInd elseif v < vMin then QMaxCap elseif v < vMinDea then (
            vMinDea - v)/abs(vMin - vMinDea)*QMaxCap else 0);
          annotation (Documentation(info="<html>
This model is similar to <a href=\"modelica://CyDER.HIL.Controls.voltVar\">
CyDER.HIL.Controls.voltVar</a> 
with the only differences that input variables have been 
changed to parameters.
</html>"));
        end voltVar_param_simple;

        model voltVar_param_simple_firstorder

          Modelica.Blocks.Interfaces.RealInput v(start=1, unit="1") "Voltage [p.u]"
            annotation (Placement(transformation(extent={{-140,-20},{-100,20}})));
          Modelica.Blocks.Interfaces.RealOutput QCon(start=0, unit="var") "Q control signal"
            annotation (Placement(transformation(extent={{100,-10},{120,10}})));
          parameter Real thr = 0.05 "over/undervoltage threshold";
          parameter Real hys= 0.01 "Hysteresis";
          final parameter Modelica.SIunits.PerUnit vMaxDea=1 + hys "Upper bound of deaband [p.u.]";
          final parameter Modelica.SIunits.PerUnit vMax=1 + thr "Voltage maximum [p.u.]";
          final parameter Modelica.SIunits.PerUnit vMinDea=1 - hys "Upper bound of deaband [p.u.]";
          final parameter Modelica.SIunits.PerUnit vMin=1 - thr "Voltage minimum [p.u.]";
          parameter Real QMaxInd(unit="var") = 1000 "Maximal Reactive Power (Inductive)";
          parameter Real QMaxCap(unit="var") = 1000 "Maximal Reactive Power (Capacitive)";
          parameter Real Tfirstorder(unit="s") = 1 "Time constant of first order";
          SCooDER.Components.Controller.Model.voltVar_param_simple
            voltVar_param1(
            thr=thr,
            hys=hys,
            QMaxInd=QMaxInd,
            QMaxCap=QMaxCap)
            annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
          Modelica.Blocks.Continuous.FirstOrder firstOrder(T=Tfirstorder)
            annotation (Placement(transformation(extent={{60,-10},{80,10}})));
        equation

          connect(voltVar_param1.v, v)
            annotation (Line(points={{-12,0},{-120,0}}, color={0,0,127}));
          connect(voltVar_param1.QCon, firstOrder.u)
            annotation (Line(points={{11,0},{11,0},{58,0}}, color={0,0,127}));
          connect(firstOrder.y, QCon)
            annotation (Line(points={{81,0},{94,0},{110,0}},        color={0,0,127}));
          annotation (Documentation(info="<html>
This model is similar to <a href=\"modelica://CyDER.HIL.Controls.voltVar\">
CyDER.HIL.Controls.voltVar</a> 
with the only differences that input variables have been 
changed to parameters.
</html>"));
        end voltVar_param_simple_firstorder;

        model voltVarWatt_param

          Modelica.Blocks.Interfaces.RealInput v(start=1, unit="1") "Voltage [p.u]"
            annotation (Placement(transformation(extent={{-140,-20},{-100,20}})));
          Modelica.Blocks.Interfaces.RealOutput Qctrl(start=0, unit="var")
            "Reactive power control signal"
            annotation (Placement(transformation(extent={{100,-60},{120,-40}})));

          parameter Real thrP = 0.05 "P: over/undervoltage threshold";
          parameter Real hysP= 0.04 "P: Hysteresis";

          parameter Real thrQ = 0.04 "Q: over/undervoltage threshold";
          parameter Real hysQ = 0.01 "Q: Hysteresis";
          parameter Real QMaxInd(unit="var") = 1000 "Maximal Reactive Power (Inductive)";
          parameter Real QMaxCap(unit="var") = 1000 "Maximal Reactive Power (Capacitive)";

          voltVar_param_simple voltWatt(
            thr=thrP,
            hys=hysP,
            QMaxInd=-1,
            QMaxCap=0)
            annotation (Placement(transformation(extent={{-8,40},{12,60}})));
          voltVar_param_simple voltVar(
            thr=thrQ,
            hys=hysQ,
            QMaxInd=QMaxInd,
            QMaxCap=QMaxCap)
            annotation (Placement(transformation(extent={{-8,-60},{12,-40}})));
          Modelica.Blocks.Interfaces.RealOutput Plim(start=1, unit="1")
            "Reactive power control signal"
            annotation (Placement(transformation(extent={{100,40},{120,60}})));
          Modelica.Blocks.Math.Add sub(k2=-1)
            annotation (Placement(transformation(extent={{40,40},{60,60}})));
          Modelica.Blocks.Sources.Constant const_p(k=1)
            annotation (Placement(transformation(extent={{0,70},{20,90}})));
        equation

          connect(voltVar.QCon, Qctrl)
            annotation (Line(points={{13,-50},{110,-50}}, color={0,0,127}));
          connect(voltWatt.v, v) annotation (Line(points={{-10,50},{-40,50},{-40,0},{-120,
                  0}}, color={0,0,127}));
          connect(voltVar.v, v) annotation (Line(points={{-10,-50},{-40,-50},{-40,0},{-120,
                  0}}, color={0,0,127}));
          connect(sub.y, Plim)
            annotation (Line(points={{61,50},{110,50}}, color={0,0,127}));
          connect(sub.u2, voltWatt.QCon) annotation (Line(points={{38,44},{20,44},{20,50},
                  {13,50}}, color={0,0,127}));
          connect(const_p.y, sub.u1) annotation (Line(points={{21,80},{30,80},{30,56},{38,
                  56}}, color={0,0,127}));
          annotation (Documentation(info="<html>
This model is similar to <a href=\"modelica://CyDER.HIL.Controls.voltVar\">
CyDER.HIL.Controls.voltVar</a> 
with the only differences that input variables have been 
changed to parameters.
</html>"));
        end voltVarWatt_param;

        model voltVarWatt_param_firstorder

          Modelica.Blocks.Interfaces.RealInput v(start=1, unit="1") "Voltage [p.u]"
            annotation (Placement(transformation(extent={{-140,-20},{-100,20}})));
          Modelica.Blocks.Interfaces.RealOutput Qctrl(start=0, unit="var")
            "Reactive power control signal"
            annotation (Placement(transformation(extent={{100,-60},{120,-40}})));

          parameter Real thrP = 0.05 "P: over/undervoltage threshold";
          parameter Real hysP= 0.04 "P: Hysteresis";

          parameter Real thrQ = 0.04 "Q: over/undervoltage threshold";
          parameter Real hysQ = 0.01 "Q: Hysteresis";
          parameter Real QMaxInd(unit="var") = 1000 "Maximal Reactive Power (Inductive)";
          parameter Real QMaxCap(unit="var") = 1000 "Maximal Reactive Power (Capacitive)";

          parameter Real Tfirstorder(unit="s") = 1 "Time constant of first order";

          voltVar_param_simple_firstorder voltWatt(
            Tfirstorder=Tfirstorder,
            thr=thrP,
            hys=hysP,
            QMaxInd=-1,
            QMaxCap=0)
            annotation (Placement(transformation(extent={{-8,40},{12,60}})));
          voltVar_param_simple_firstorder voltVar(
            thr=thrQ,
            hys=hysQ,
            QMaxInd=QMaxInd,
            QMaxCap=QMaxCap,
            Tfirstorder=Tfirstorder)
            annotation (Placement(transformation(extent={{-8,-60},{12,-40}})));
          Modelica.Blocks.Interfaces.RealOutput Plim(start=1, unit="1")
            "Reactive power control signal"
            annotation (Placement(transformation(extent={{100,40},{120,60}})));
          Modelica.Blocks.Math.Add sub(k2=-1)
            annotation (Placement(transformation(extent={{40,40},{60,60}})));
          Modelica.Blocks.Sources.Constant const_p(k=1)
            annotation (Placement(transformation(extent={{0,70},{20,90}})));
        equation

          connect(voltVar.QCon, Qctrl)
            annotation (Line(points={{13,-50},{110,-50}}, color={0,0,127}));
          connect(voltWatt.v, v) annotation (Line(points={{-10,50},{-40,50},{-40,0},{-120,
                  0}}, color={0,0,127}));
          connect(voltVar.v, v) annotation (Line(points={{-10,-50},{-40,-50},{-40,0},{-120,
                  0}}, color={0,0,127}));
          connect(sub.y, Plim)
            annotation (Line(points={{61,50},{110,50}}, color={0,0,127}));
          connect(sub.u2, voltWatt.QCon) annotation (Line(points={{38,44},{20,44},{20,50},
                  {13,50}}, color={0,0,127}));
          connect(const_p.y, sub.u1) annotation (Line(points={{21,80},{30,80},{30,56},{38,
                  56}}, color={0,0,127}));
          annotation (Documentation(info="<html>
This model is similar to <a href=\"modelica://CyDER.HIL.Controls.voltVar\">
CyDER.HIL.Controls.voltVar</a> 
with the only differences that input variables have been 
changed to parameters.
</html>"));
        end voltVarWatt_param_firstorder;

        model Pv_Inv_VoltVarWatt_simple
          // Weather data
          parameter String weather_file = "" "Path to weather file";
          // PV generation
          parameter Real n(min=0, unit="1") = 14 "Number of PV modules";
          parameter Real A(min=0, unit="m2") = 1.65 "Net surface area per module";
          parameter Real eta(min=0, max=1, unit="1") = 0.158
            "Module conversion efficiency";
          parameter Real lat(unit="deg") = 37.9 "Latitude";
          parameter Real til(unit="deg") = 10 "Surface tilt";
          parameter Real azi(unit="deg") = 0 "Surface azimuth 0-S, 90-W, 180-N, 270-E ";
          // VoltVarWatt
          parameter Real thrP = 0.05 "P: over/undervoltage threshold";
          parameter Real hysP= 0.04 "P: Hysteresis";
          parameter Real thrQ = 0.04 "Q: over/undervoltage threshold";
          parameter Real hysQ = 0.01 "Q: Hysteresis";
          parameter Real QMaxInd(unit="var") = 1000 "Maximal Reactive Power (Inductive)";
          parameter Real QMaxCap(unit="var") = 1000 "Maximal Reactive Power (Capacitive)";

          SCooDER.Components.Photovoltaics.Model.PVModule_simple PV(
            n=n,
            A=A,
            eta=eta,
            lat=lat,
            til=til,
            azi=azi)
            annotation (Placement(transformation(extent={{-10,40},{10,60}})));
          Buildings.BoundaryConditions.WeatherData.ReaderTMY3 weaDatInpCon(
              computeWetBulbTemperature=false, filNam=weather_file)
            "Weather data reader with radiation data obtained from the inputs' connectors"
            annotation (Placement(transformation(extent={{-80,60},{-60,80}})));
          voltVarWatt_param VoltVarWatt(
            thrP=thrP,
            hysP=hysP,
            thrQ=thrQ,
            hysQ=hysQ,
            QMaxInd=QMaxInd,
            QMaxCap=QMaxCap)
            annotation (Placement(transformation(extent={{-50,-10},{-30,10}})));
          Modelica.Blocks.Interfaces.RealInput v(start=1, unit="1") "Voltage [p.u]"
            annotation (Placement(transformation(extent={{-140,-20},{-100,20}})));
          Modelica.Blocks.Interfaces.RealOutput Q(start=0, unit="var")
            "Reactive power"
            annotation (Placement(transformation(extent={{100,-60},{120,-40}})));
          Modelica.Blocks.Interfaces.RealOutput P(unit="W", start=0)
            "Active power"
            annotation (Placement(transformation(extent={{100,40},{120,60}})));
        equation
          connect(weaDatInpCon.weaBus, PV.weaBus) annotation (Line(
              points={{-60,70},{-40,70},{-40,54},{-10,54}},
              color={255,204,51},
              thickness=0.5));
          connect(VoltVarWatt.v, v)
            annotation (Line(points={{-52,0},{-120,0}}, color={0,0,127}));
          connect(PV.scale, VoltVarWatt.Plim) annotation (Line(points={{-12,46},
                  {-20,46},{-20,5},{-29,5}}, color={0,0,127}));
          connect(PV.P, P)
            annotation (Line(points={{11,50},{110,50}}, color={0,0,127}));
          connect(Q, VoltVarWatt.Qctrl) annotation (Line(points={{110,-50},{-20,
                  -50},{-20,-5},{-29,-5}}, color={0,0,127}));
          annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
                coordinateSystem(preserveAspectRatio=false)));
        end Pv_Inv_VoltVarWatt_simple;

        model Pv_Inv_VoltVarWatt_simple_Slim
          // Weather data
          parameter String weather_file = "" "Path to weather file";
          // PV generation
          parameter Real n(min=0, unit="1") = 26 "Number of PV modules";
          parameter Real A(min=0, unit="m2") = 1.65 "Net surface area per module";
          parameter Real eta(min=0, max=1, unit="1") = 0.158
            "Module conversion efficiency";
          parameter Real lat(unit="deg") = 37.9 "Latitude";
          parameter Real til(unit="deg") = 10 "Surface tilt";
          parameter Real azi(unit="deg") = 0 "Surface azimuth 0-S, 90-W, 180-N, 270-E ";
          // VoltVarWatt
          parameter Real thrP = 0.05 "P: over/undervoltage threshold";
          parameter Real hysP= 0.04 "P: Hysteresis";
          parameter Real thrQ = 0.04 "Q: over/undervoltage threshold";
          parameter Real hysQ = 0.01 "Q: Hysteresis";
          parameter Real SMax(unit="VA") = 7600 "Maximal Apparent Power";
          parameter Real QMaxInd(unit="var") = 3300 "Maximal Reactive Power (Inductive)";
          parameter Real QMaxCap(unit="var") = 3300 "Maximal Reactive Power (Capacitive)";

          SCooDER.Components.Photovoltaics.Model.PVModule_simple PV(
            n=n,
            A=A,
            eta=eta,
            lat=lat,
            til=til,
            azi=azi)
            annotation (Placement(transformation(extent={{-10,40},{10,60}})));
          Buildings.BoundaryConditions.WeatherData.ReaderTMY3 weaDatInpCon(
              computeWetBulbTemperature=false, filNam=weather_file)
            "Weather data reader with radiation data obtained from the inputs' connectors"
            annotation (Placement(transformation(extent={{-80,60},{-60,80}})));
          Modelica.Blocks.Interfaces.RealInput v(start=1, unit="1") "Voltage [p.u]"
            annotation (Placement(transformation(extent={{-140,-20},{-100,20}})));
          Modelica.Blocks.Interfaces.RealOutput Q(start=0, unit="var")
            "Reactive power"
            annotation (Placement(transformation(extent={{100,-60},{120,-40}})));
          Modelica.Blocks.Interfaces.RealOutput P(unit="W", start=0)
            "Active power"
            annotation (Placement(transformation(extent={{100,40},{120,60}})));
          Modelica.Blocks.Sources.RealExpression S_curtail_P(y=min(sqrt(SMax^2
                 - VoltVarWatt.Qctrl^2), PV.P))
                          annotation (Placement(transformation(extent={{0,-10},
                    {80,10}})));
          voltVarWatt_param VoltVarWatt(
            thrP=thrP,
            hysP=hysP,
            thrQ=thrQ,
            hysQ=hysQ,
            QMaxInd=QMaxInd,
            QMaxCap=QMaxCap)
            annotation (Placement(transformation(extent={{-50,-10},{-30,10}})));
        equation
          connect(weaDatInpCon.weaBus, PV.weaBus) annotation (Line(
              points={{-60,70},{-40,70},{-40,54},{-10,54}},
              color={255,204,51},
              thickness=0.5));
          connect(PV.scale, VoltVarWatt.Plim) annotation (Line(points={{-12,46},
                  {-20,46},{-20,5},{-29,5}}, color={0,0,127}));
          connect(VoltVarWatt.v, v)
            annotation (Line(points={{-52,0},{-120,0}}, color={0,0,127}));
          connect(P, S_curtail_P.y) annotation (Line(points={{110,50},{88,50},{
                  88,0},{84,0}}, color={0,0,127}));
          connect(VoltVarWatt.Qctrl, Q) annotation (Line(points={{-29,-5},{-20,
                  -5},{-20,-50},{110,-50}}, color={0,0,127}));
          annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
                coordinateSystem(preserveAspectRatio=false)));
        end Pv_Inv_VoltVarWatt_simple_Slim;

        model Pv_Inv_VoltVarWatt_simple_Slim_weabus
          // Weather data
          //parameter String weather_file = "" "Path to weather file";
          // PV generation
          parameter Real n(min=0, unit="1") = 26 "Number of PV modules";
          parameter Real A(min=0, unit="m2") = 1.65 "Net surface area per module";
          parameter Real eta(min=0, max=1, unit="1") = 0.158
            "Module conversion efficiency";
          parameter Real lat(unit="deg") = 37.9 "Latitude";
          parameter Real til(unit="deg") = 10 "Surface tilt";
          parameter Real azi(unit="deg") = 0 "Surface azimuth 0-S, 90-W, 180-N, 270-E ";
          // VoltVarWatt
          parameter Real thrP = 0.05 "P: over/undervoltage threshold";
          parameter Real hysP= 0.04 "P: Hysteresis";
          parameter Real thrQ = 0.04 "Q: over/undervoltage threshold";
          parameter Real hysQ = 0.01 "Q: Hysteresis";
          parameter Real SMax(unit="VA") = 7600 "Maximal Apparent Power";
          parameter Real QMaxInd(unit="var") = 3300 "Maximal Reactive Power (Inductive)";
          parameter Real QMaxCap(unit="var") = 3300 "Maximal Reactive Power (Capacitive)";

          SCooDER.Components.Photovoltaics.Model.PVModule_simple PV(
            n=n,
            A=A,
            eta=eta,
            lat=lat,
            til=til,
            azi=azi) annotation (Placement(transformation(extent={{-10,40},{10,60}})));
          Modelica.Blocks.Interfaces.RealInput v(start=1, unit="1") "Voltage [p.u]"
            annotation (Placement(transformation(extent={{-140,-20},{-100,20}})));
          Modelica.Blocks.Interfaces.RealOutput Q(start=0, unit="var")
            "Reactive power"
            annotation (Placement(transformation(extent={{100,-60},{120,-40}})));
          Modelica.Blocks.Interfaces.RealOutput P(unit="W", start=0)
            "Active power"
            annotation (Placement(transformation(extent={{100,40},{120,60}})));
          voltVarWatt_param VoltVarWatt(
            thrP=thrP,
            hysP=hysP,
            thrQ=thrQ,
            hysQ=hysQ,
            QMaxInd=QMaxInd,
            QMaxCap=QMaxCap)
            annotation (Placement(transformation(extent={{-50,-10},{-30,10}})));
          Buildings.BoundaryConditions.WeatherData.Bus
                          weaBus "Bus with weather data"
            annotation (Placement(transformation(extent={{-110,60},{-90,80}})));
          Modelica.Blocks.Sources.RealExpression S_curtail_P(y=min(sqrt(SMax^2 -
                VoltVarWatt.Qctrl^2), PV.P))
                          annotation (Placement(transformation(extent={{0,-10},{80,10}})));
        equation
          connect(PV.scale, VoltVarWatt.Plim) annotation (Line(points={{-12,46},{-20,46},
                  {-20,5},{-29,5}}, color={0,0,127}));
          connect(VoltVarWatt.v, v)
            annotation (Line(points={{-52,0},{-120,0}}, color={0,0,127}));
          connect(weaBus, PV.weaBus) annotation (Line(
              points={{-100,70},{-72,70},{-72,54},{-10,54}},
              color={255,204,51},
              thickness=0.5), Text(
              string="%first",
              index=-1,
              extent={{-6,3},{-6,3}},
              horizontalAlignment=TextAlignment.Right));
          connect(P, S_curtail_P.y) annotation (Line(points={{110,50},{88,50},{88,0},{84,
                  0}}, color={0,0,127}));
          connect(Q, VoltVarWatt.Qctrl) annotation (Line(points={{110,-50},{-20,-50},{-20,
                  -5},{-29,-5}}, color={0,0,127}));
          annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
                coordinateSystem(preserveAspectRatio=false)));
        end Pv_Inv_VoltVarWatt_simple_Slim_weabus;

        model Pv_Inv_VoltVarWatt_simple_Slim_uStoarge
          // Weather data
          parameter String weather_file = "" "Path to weather file";
          // PV generation
          parameter Real n(min=0, unit="1") = 26 "Number of PV modules";
          parameter Real A(min=0, unit="m2") = 1.65 "Net surface area per module";
          parameter Real eta(min=0, max=1, unit="1") = 0.158
            "Module conversion efficiency";
          parameter Real lat(unit="deg") = 37.9 "Latitude";
          parameter Real til(unit="deg") = 10 "Surface tilt";
          parameter Real azi(unit="deg") = 0 "Surface azimuth 0-S, 90-W, 180-N, 270-E ";
          // VoltVarWatt
          parameter Real thrP = 0.05 "P: over/undervoltage threshold";
          parameter Real hysP= 0.04 "P: Hysteresis";
          parameter Real thrQ = 0.04 "Q: over/undervoltage threshold";
          parameter Real hysQ = 0.01 "Q: Hysteresis";
          parameter Real SMax(unit="VA") = 7600 "Maximal Apparent Power";
          parameter Real QMaxInd(unit="var") = 3300 "Maximal Reactive Power (Inductive)";
          parameter Real QMaxCap(unit="var") = 3300 "Maximal Reactive Power (Capacitive)";
          // Battery
          parameter Real P_discharge(unit="W", min=0) = 1000 "Battery Maximal Discharge";
          parameter Real EMax(unit="W.h", min=0) = 1000 "Battery Capacity";
          parameter Real SOC_start(min=0, max=1, unit="1") = 0.1 "Initial SOC value";
          parameter Real SOC_min(min=0, max=1, unit="1") = 0.1 "Minimum SOC value";
          parameter Real SOC_max(min=0, max=1, unit="1") = 1 "Maximum SOC value";
          parameter Real etaCha(min=0, max=1, unit="1") = 0.96 "Charging efficiency";
          parameter Real etaDis(min=0, max=1, unit="1") = 0.96 "Discharging efficiency";

          SCooDER.Components.Photovoltaics.Model.PVModule_simple PV(
            n=n,
            A=A,
            eta=eta,
            lat=lat,
            til=til,
            azi=azi)
            annotation (Placement(transformation(extent={{-10,70},{10,90}})));
          Buildings.BoundaryConditions.WeatherData.ReaderTMY3 Weather(
              computeWetBulbTemperature=false, filNam=weather_file)
            "Weather data reader with radiation data obtained from the inputs' connectors"
            annotation (Placement(transformation(extent={{-80,74},{-60,94}})));
          Modelica.Blocks.Interfaces.RealInput v(start=1, unit="1") "Voltage [p.u]"
            annotation (Placement(transformation(extent={{-140,-20},{-100,20}})));
          Modelica.Blocks.Interfaces.RealOutput Q(start=0, unit="var") "Reactive power"
            annotation (Placement(transformation(extent={{100,-20},{120,0}})));
          Modelica.Blocks.Interfaces.RealOutput P(unit="W", start=0) "Active power"
            annotation (Placement(transformation(extent={{100,20},{120,40}})));
          Modelica.Blocks.Sources.RealExpression P_feedin(y=min(sqrt(SMax^2 - Q^2), PV.P))
            annotation (Placement(transformation(extent={{-26,30},{54,50}})));
          voltVarWatt_param VoltVarWatt(
            thrP=thrP,
            hysP=hysP,
            thrQ=thrQ,
            hysQ=hysQ,
            QMaxInd=QMaxInd,
            QMaxCap=QMaxCap)
            annotation (Placement(transformation(extent={{-70,-10},{-50,10}})));
          SCooDER.Components.Battery.Model.Battery battery(
            SOC_start=SOC_start,
            SOC_min=SOC_min,
            etaCha=etaCha,
            etaDis=etaDis,
            SOC_max=SOC_max,
            EMax=EMax*1000)
            annotation (Placement(transformation(extent={{40,-90},{60,-70}})));
          Modelica.Blocks.Sources.RealExpression P_battery_control(y=if (PV.P - P) > 0.1
                 then (PV.P - P) else -1*min(sqrt(SMax^2 - Q^2) - P_feedin.y,
                P_discharge))
            annotation (Placement(transformation(extent={{-80,-90},{0,-70}})));
          Modelica.Blocks.Interfaces.RealOutput SOC(start=SOC_min, unit="1") "State of Charge"
            annotation (Placement(transformation(extent={{100,-60},{120,-40}})));
          Modelica.Blocks.Interfaces.RealOutput P_batt(start=0, unit="W")
            "Power demand Battery"
            annotation (Placement(transformation(extent={{100,-100},{120,-80}})));
          Modelica.Blocks.Interfaces.RealOutput SOE(unit="W.h") "State of Energy"
            annotation (Placement(transformation(extent={{100,-80},{120,-60}})));
          Modelica.Blocks.Math.Add Sum_P
            annotation (Placement(transformation(extent={{70,20},{90,40}})));
          Modelica.Blocks.Sources.RealExpression P_battery(y=if P_batt < 0 then -1*
                P_batt else 0)
            annotation (Placement(transformation(extent={{-26,10},{54,30}})));
          Modelica.Blocks.Sources.RealExpression P_curtailed(y=PV.P - P_feedin.y)
            annotation (Placement(transformation(extent={{-80,-60},{0,-40}})));
        equation
          connect(Weather.weaBus, PV.weaBus) annotation (Line(
              points={{-60,84},{-10,84}},
              color={255,204,51},
              thickness=0.5));
          connect(PV.scale, VoltVarWatt.Plim) annotation (Line(points={{-12,76},{-40,76},
                  {-40,5},{-49,5}}, color={0,0,127}));
          connect(VoltVarWatt.v, v)
            annotation (Line(points={{-72,0},{-120,0}}, color={0,0,127}));
          connect(SOC, battery.SOC) annotation (Line(points={{110,-50},{70,-50},{70,-72},
                  {61,-72}}, color={0,0,127}));
          connect(Sum_P.y, P)
            annotation (Line(points={{91,30},{110,30}}, color={0,0,127}));
          connect(P_feedin.y, Sum_P.u1) annotation (Line(points={{58,40},{64,40},{64,36},
                  {68,36}}, color={0,0,127}));
          connect(Sum_P.u2, P_battery.y) annotation (Line(points={{68,24},{64,24},{64,20},
                  {58,20}}, color={0,0,127}));
          connect(Q, VoltVarWatt.Qctrl) annotation (Line(points={{110,-10},{-40,-10},{-40,
                  -5},{-49,-5}}, color={0,0,127}));
          connect(P_battery_control.y, battery.P_ctrl)
            annotation (Line(points={{4,-80},{38,-80}}, color={0,0,127}));
          connect(battery.SOE, SOE) annotation (Line(points={{61,-75},{80.5,-75},{80.5,-70},
                  {110,-70}}, color={0,0,127}));
          connect(battery.P_batt, P_batt) annotation (Line(points={{61,-80},{80,-80},{80,
                  -90},{110,-90}}, color={0,0,127}));
          annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
                coordinateSystem(preserveAspectRatio=false)));
        end Pv_Inv_VoltVarWatt_simple_Slim_uStoarge;

      end Model;

      package Examples
        extends Modelica.Icons.ExamplesPackage;
        model Test_voltvar

          Modelica.Blocks.Sources.Ramp ramp(
            duration=1,
            startTime=0,
            height=0.2,
            offset=0.9)
            annotation (Placement(transformation(extent={{-90,-10},{-70,10}})));
          Modelica.Blocks.Sources.Constant upper_voltage(k=1.05)
            annotation (Placement(transformation(extent={{-60,50},{-40,70}})));
          Modelica.Blocks.Sources.Constant lower_voltage(k=0.95)
            annotation (Placement(transformation(extent={{-60,-70},{-40,-50}})));
          Model.voltvar voltvar
            annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
          Modelica.Blocks.Sources.Constant upper_deadband_voltage(k=1.01)
            annotation (Placement(transformation(extent={{-60,10},{-40,30}})));
          Modelica.Blocks.Sources.Constant lower_deadband_voltage(k=0.99)
            annotation (Placement(transformation(extent={{-60,-30},{-40,-10}})));
          Modelica.Blocks.Sources.Constant qmax_inductive(k=1) annotation (Placement(
                transformation(
                extent={{-10,-10},{10,10}},
                rotation=-90,
                origin={40,60})));
          Modelica.Blocks.Sources.Constant qmax_capacitive(k=0.2) annotation (Placement(
                transformation(
                extent={{-10,-10},{10,10}},
                rotation=-90,
                origin={0,60})));
        equation
          connect(ramp.y, voltvar.v_pu)
            annotation (Line(points={{-69,0},{-12,0}}, color={0,0,127}));
          connect(lower_voltage.y, voltvar.v_min) annotation (Line(points={{-39,
                  -60},{-20,-60},{-20,-8},{-12,-8}}, color={0,0,127}));
          connect(upper_voltage.y, voltvar.v_max) annotation (Line(points={{-39,
                  60},{-20,60},{-20,8},{-12,8}}, color={0,0,127}));
          connect(voltvar.v_mindead, lower_deadband_voltage.y) annotation (Line(
                points={{-12,-4},{-30,-4},{-30,-20},{-39,-20}}, color={0,0,127}));
          connect(upper_deadband_voltage.y, voltvar.v_maxdead) annotation (Line(
                points={{-39,20},{-30,20},{-30,4},{-12,4}}, color={0,0,127}));
          connect(qmax_capacitive.y, voltvar.q_maxcap) annotation (Line(points={{-1.9984e-015,
                  49},{0,49},{0,30},{-4,30},{-4,12}}, color={0,0,127}));
          connect(qmax_inductive.y, voltvar.q_maxind) annotation (Line(points={{40,49},{40,
                  49},{40,40},{12,40},{12,20},{2,20},{2,12}}, color={0,0,127}));
          annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
                coordinateSystem(preserveAspectRatio=false)));
        end Test_voltvar;

        model Validate_VoltVarControl

          Modelica.Blocks.Sources.Ramp ramp(
            duration=1,
            startTime=0,
            height=0.2,
            offset=0.9)
            annotation (Placement(transformation(extent={{-90,-10},{-70,10}})));
          Modelica.Blocks.Sources.Constant upper_voltage(k=1.05)
            annotation (Placement(transformation(extent={{-60,50},{-40,70}})));
          Modelica.Blocks.Sources.Constant lower_voltage(k=0.95)
            annotation (Placement(transformation(extent={{-60,-70},{-40,-50}})));
          Modelica.Blocks.Sources.Constant upper_deadband_voltage(k=1.01)
            annotation (Placement(transformation(extent={{-60,10},{-40,30}})));
          Modelica.Blocks.Sources.Constant lower_deadband_voltage(k=0.99)
            annotation (Placement(transformation(extent={{-60,-30},{-40,-10}})));
          Modelica.Blocks.Sources.Constant qmax_inductive(k=1) annotation (Placement(
                transformation(
                extent={{-10,-10},{10,10}},
                rotation=-90,
                origin={40,60})));
          Modelica.Blocks.Sources.Constant qmax_capacitive(k=0.2) annotation (Placement(
                transformation(
                extent={{-10,-10},{10,10}},
                rotation=-90,
                origin={0,60})));
          SCooDER.Components.Controller.Model.voltvar voltVar
            annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
        equation
          connect(ramp.y, voltVar.v_pu)
            annotation (Line(points={{-69,0},{-12,0}}, color={0,0,127}));
          connect(lower_voltage.y, voltVar.v_min) annotation (Line(points={{-39,
                  -60},{-20,-60},{-20,-8},{-12,-8}}, color={0,0,127}));
          connect(upper_voltage.y, voltVar.v_max) annotation (Line(points={{-39,
                  60},{-20,60},{-20,8},{-12,8}}, color={0,0,127}));
          connect(voltVar.v_mindead, lower_deadband_voltage.y) annotation (Line(
                points={{-12,-4},{-30,-4},{-30,-20},{-39,-20}}, color={0,0,127}));
          connect(upper_deadband_voltage.y, voltVar.v_maxdead) annotation (Line(
                points={{-39,20},{-30,20},{-30,4},{-12,4}}, color={0,0,127}));
          connect(qmax_capacitive.y, voltVar.q_maxcap) annotation (Line(points={{-1.9984e-015,
                  49},{0,49},{0,30},{-4,30},{-4,12}}, color={0,0,127}));
          connect(qmax_inductive.y, voltVar.q_maxind) annotation (Line(points={{40,49},{40,
                  49},{40,40},{12,40},{12,20},{2,20},{2,12}}, color={0,0,127}));
          annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
                coordinateSystem(preserveAspectRatio=false)));
        end Validate_VoltVarControl;

        model Validate_VoltVarControl_param

          Modelica.Blocks.Sources.Ramp ramp(
            duration=1,
            startTime=0,
            height=0.2,
            offset=0.9)
            annotation (Placement(transformation(extent={{-90,-10},{-70,10}})));
          SCooDER.Components.Controller.Model.voltVar_param_simple
            voltVar_param
            annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
        equation
          connect(voltVar_param.v, ramp.y)
            annotation (Line(points={{-12,0},{-69,0}}, color={0,0,127}));
          annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
                coordinateSystem(preserveAspectRatio=false)));
        end Validate_VoltVarControl_param;

        model Validate_VoltVarWattControl
          Modelica.Blocks.Sources.Ramp ramp(
            duration=1,
            startTime=0,
            height=0.2,
            offset=0.9)
            annotation (Placement(transformation(extent={{-90,-10},{-70,10}})));
          SCooDER.Components.Controller.Model.voltVarWatt_param_firstorder
            voltVarWatt_param_firstorder(Tfirstorder=0.001)
            annotation (Placement(transformation(extent={{-8,-10},{12,10}})));
        equation
          connect(voltVarWatt_param_firstorder.v, ramp.y)
            annotation (Line(points={{-10,0},{-69,0}}, color={0,0,127}));
          annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
                coordinateSystem(preserveAspectRatio=false)));
        end Validate_VoltVarWattControl;

        model Test_Pv_Inv_VoltVarWatt_simple_Slim
          extends Modelica.Icons.Example;
          SCooDER.Components.Controller.Model.Pv_Inv_VoltVarWatt_simple_Slim
            VVW(weather_file=
                "C:/Users/Christoph/Documents/SCooDER/SCooDER_simulation/ExampleData/USA_CA_San.Francisco.Intl.AP.724940_TMY3.mos")
            annotation (Placement(transformation(extent={{-80,50},{-60,70}})));
          SCooDER.Components.Inverter.Model.InverterLoad_PQ load_VVW(V_start=120)
            annotation (Placement(transformation(extent={{20,70},{0,50}})));
          Buildings.Electrical.AC.OnePhase.Sensors.GeneralizedSensor sens_VVW
            annotation (Placement(transformation(extent={{80,60},{60,80}})));
          Buildings.Electrical.AC.OnePhase.Sensors.Probe ref_VVW(V_nominal=120)
            annotation (Placement(transformation(
                extent={{-10,10},{10,-10}},
                rotation=-90,
                origin={20,30})));
          Buildings.Electrical.AC.OnePhase.Sources.FixedVoltage fixVol(f=60, V=120)
            annotation (Placement(transformation(extent={{100,80},{80,100}})));
          Modelica.Blocks.Math.Gain kW_to_W(k=1000)
            annotation (Placement(transformation(extent={{-40,70},{-20,90}})));
          Modelica.Blocks.Math.Gain kvar_to_var(k=1000)
            annotation (Placement(transformation(extent={{-40,30},{-20,50}})));
          Buildings.Electrical.AC.OnePhase.Lines.Line line_VVW(
            V_nominal=120,
            P_nominal=1000,
            l=500) annotation (Placement(transformation(extent={{60,60},{40,80}})));
          SCooDER.Components.Controller.Model.Pv_Inv_VoltVarWatt_simple_Slim
            base(
            weather_file=
                "C:/Users/Christoph/Documents/SCooDER/SCooDER_simulation/ExampleData/USA_CA_San.Francisco.Intl.AP.724940_TMY3.mos",
            thrP=1,
            hysP=1,
            QMaxInd=0,
            QMaxCap=0) annotation (Placement(transformation(extent={{-80,-50},{
                    -60,-30}})));

          SCooDER.Components.Inverter.Model.InverterLoad_PQ load_base(V_start=120)
            annotation (Placement(transformation(extent={{20,-30},{0,-50}})));
          Buildings.Electrical.AC.OnePhase.Sensors.Probe ref_base(V_nominal=120)
            annotation (Placement(transformation(
                extent={{-10,10},{10,-10}},
                rotation=-90,
                origin={20,-70})));
          Modelica.Blocks.Math.Gain kW_to_W1(k=1000)
            annotation (Placement(transformation(extent={{-40,-30},{-20,-10}})));
          Modelica.Blocks.Math.Gain kvar_to_var1(k=1000)
            annotation (Placement(transformation(extent={{-40,-70},{-20,-50}})));
          Buildings.Electrical.AC.OnePhase.Sensors.GeneralizedSensor sens_base
            annotation (Placement(transformation(extent={{80,-40},{60,-20}})));
          Buildings.Electrical.AC.OnePhase.Lines.Line line_base(
            V_nominal=120,
            P_nominal=1000,
            l=500) annotation (Placement(transformation(extent={{60,-40},{40,-20}})));
        equation
          connect(kW_to_W.u, VVW.P) annotation (Line(points={{-42,80},{-50,80},{-50,65},
                  {-59,65}}, color={0,0,127}));
          connect(kvar_to_var.u, VVW.Q) annotation (Line(points={{-42,40},{-50,40},{-50,
                  55},{-59,55}}, color={0,0,127}));
          connect(kW_to_W.y, load_VVW.Pow) annotation (Line(points={{-19,80},{-10,80},{-10,
                  60},{-2,60}}, color={0,0,127}));
          connect(load_VVW.Q, kvar_to_var.y) annotation (Line(points={{-2,54},{-10,54},{
                  -10,40},{-19,40}}, color={0,0,127}));
          connect(ref_VVW.V, VVW.v) annotation (Line(points={{17,23},{-90,23},{-90,60},{
                  -82,60}}, color={0,0,127}));
          connect(ref_VVW.term, load_VVW.terminal) annotation (Line(points={{29,30},{40,
                  30},{40,60},{20,60}}, color={0,120,120}));
          connect(kW_to_W1.u, base.P) annotation (Line(points={{-42,-20},{-50,-20},{-50,
                  -35},{-59,-35}}, color={0,0,127}));
          connect(kvar_to_var1.u, base.Q) annotation (Line(points={{-42,-60},{-50,-60},{
                  -50,-45},{-59,-45}}, color={0,0,127}));
          connect(kW_to_W1.y, load_base.Pow) annotation (Line(points={{-19,-20},{-10,-20},
                  {-10,-40},{-2,-40}}, color={0,0,127}));
          connect(load_base.Q, kvar_to_var1.y) annotation (Line(points={{-2,-46},{-10,-46},
                  {-10,-60},{-19,-60}}, color={0,0,127}));
          connect(ref_base.V, base.v) annotation (Line(points={{17,-77},{-90,-77},{-90,-40},
                  {-82,-40}}, color={0,0,127}));
          connect(ref_base.term, load_base.terminal) annotation (Line(points={{29,-70},{
                  40,-70},{40,-40},{20,-40}}, color={0,120,120}));
          connect(line_VVW.terminal_n, sens_VVW.terminal_p)
            annotation (Line(points={{60,70},{60,70}}, color={0,120,120}));
          connect(line_base.terminal_n, sens_base.terminal_p)
            annotation (Line(points={{60,-30},{60,-30}}, color={0,120,120}));
          connect(fixVol.terminal, sens_VVW.terminal_n)
            annotation (Line(points={{80,90},{80,70}}, color={0,120,120}));
          connect(fixVol.terminal, sens_base.terminal_n)
            annotation (Line(points={{80,90},{80,-30}}, color={0,120,120}));
          connect(line_base.terminal_p, load_base.terminal)
            annotation (Line(points={{40,-30},{40,-40},{20,-40}}, color={0,120,120}));
          connect(line_VVW.terminal_p, load_VVW.terminal)
            annotation (Line(points={{40,70},{40,60},{20,60}}, color={0,120,120}));
          annotation (Icon(coordinateSystem(preserveAspectRatio=false)),
          experiment(StartTime=0, StopTime=86400),
          Diagram(
                coordinateSystem(preserveAspectRatio=false)));
        end Test_Pv_Inv_VoltVarWatt_simple_Slim;

        model Test_Pv_Inv_VoltVarWatt_simple_Slim_curtail
          extends Modelica.Icons.Example;
          SCooDER.Components.Controller.Model.Pv_Inv_VoltVarWatt_simple_Slim
            VVW(
            thrP=1,
            hysP=1,
            n=75,
            weather_file=
                "C:/Users/Christoph/Documents/SmartInverter/smartinverter_simulation/ExampleData/USA_CA_San.Francisco.Intl.AP.724940_TMY3.mos")
            annotation (Placement(transformation(extent={{-10,-10},{10,10}})));

          Modelica.Blocks.Sources.Ramp ramp(
            height=0.5,
            offset=1,
            startTime=43200,
            duration=3600*2)
            annotation (Placement(transformation(extent={{-60,-10},{-40,10}})));
        equation
          connect(ramp.y, VVW.v)
            annotation (Line(points={{-39,0},{-12,0}}, color={0,0,127}));
          annotation (Icon(coordinateSystem(preserveAspectRatio=false)),
            experiment(StartTime=0, StopTime=86400),
            Diagram(
                coordinateSystem(preserveAspectRatio=false)));
        end Test_Pv_Inv_VoltVarWatt_simple_Slim_curtail;

        model Test_Pv_Inv_VoltVarWatt_simple_Slim_uStorage
          extends Modelica.Icons.Example;
          SCooDER.Components.Controller.Model.Pv_Inv_VoltVarWatt_simple_Slim_uStoarge
            VVW(
            thrP=1,
            hysP=1,
            n=75,
            weather_file=
                "C:/Users/Christoph/Documents/SmartInverter/smartinverter_simulation/ExampleData/USA_CA_San.Francisco.Intl.AP.724940_TMY3.mos",
            P_discharge=1.5,
            EMax=10)
            annotation (Placement(transformation(extent={{-10,-10},{10,10}})));

          Modelica.Blocks.Sources.Ramp ramp(
            height=0.5,
            offset=1,
            startTime=43200,
            duration=3600*2)
            annotation (Placement(transformation(extent={{-60,-10},{-40,10}})));
        equation
          connect(ramp.y, VVW.v)
            annotation (Line(points={{-39,0},{-12,0}}, color={0,0,127}));
          annotation (Icon(coordinateSystem(preserveAspectRatio=false)),
            experiment(StartTime=0, StopTime=86400),
            Diagram(
                coordinateSystem(preserveAspectRatio=false)));
        end Test_Pv_Inv_VoltVarWatt_simple_Slim_uStorage;
      end Examples;

      package Utility

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
      end Utility;
    end Controller;

    package Grid
      package Model
        model GridModel
          Buildings.Electrical.AC.ThreePhasesUnbalanced.Sources.Grid grid(f=60, V=208)
            annotation (Placement(transformation(extent={{-10,60},{10,80}})));
          Buildings.Electrical.AC.ThreePhasesUnbalanced.Loads.Resistive load(
            P_nominal=-1200,
            mode=Buildings.Electrical.Types.Load.FixedZ_steady_state,
            V_nominal=120)
            annotation (Placement(transformation(extent={{20,0},{40,20}})));
          Network ieee34(V_nominal=208, redeclare
              Buildings.Electrical.Transmission.Grids.IEEE_34_AL120 grid)
            annotation (Placement(transformation(extent={{-80,0},{-60,20}})));
          Network ieee13(V_nominal=208, redeclare Records.IEEE_13 grid)
            annotation (Placement(transformation(extent={{-80,-40},{-60,-20}})));
          Buildings.Electrical.AC.ThreePhasesUnbalanced.Loads.Resistive load13(
            P_nominal=-1200,
            mode=Buildings.Electrical.Types.Load.FixedZ_steady_state,
            V_nominal=120)
            annotation (Placement(transformation(extent={{20,-40},{40,-20}})));
        equation
          connect(grid.terminal, ieee34.terminal[1]) annotation (Line(points={{0,60},{0,
                  60},{0,10},{-60,10}}, color={0,120,120}));
          connect(load.terminal, ieee34.terminal[7])
            annotation (Line(points={{20,10},{-20,10},{-60,10}}, color={0,120,120}));
          connect(grid.terminal, ieee13.terminal[1]) annotation (Line(points={{0,60},{0,
                  60},{0,-30},{-60,-30}}, color={0,120,120}));
          connect(load13.terminal, ieee13.terminal[13]) annotation (Line(points={{20,
                  -30},{-20,-30},{-60,-30}}, color={0,120,120}));
          annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
                coordinateSystem(preserveAspectRatio=false)));
        end GridModel;

        model Network
          "Three phases unbalanced AC network without neutral cable"
          extends Buildings.Electrical.Transmission.BaseClasses.PartialNetwork(
            redeclare
              Buildings.Electrical.AC.ThreePhasesUnbalanced.Interfaces.Terminal_p
              terminal,
            redeclare replaceable
              Buildings.Electrical.Transmission.Grids.TestGrid2Nodes grid,
            redeclare SCooDER.Components.Grid.Model.Line lines(commercialCable=
                  grid.cables));
          Modelica.SIunits.Voltage VAbs[3,grid.nNodes] "RMS voltage of the grid nodes";
          Modelica.SIunits.Voltage Vpu[3,grid.nNodes] "Scaled voltage of the grid nodes";
          Real P[3,grid.nNodes](each unit="W") "Phase Active Power";
          Real Q[3,grid.nNodes](each unit="var") "Phase Reactive Power";
          Real S_temp[3,grid.nNodes,2](each unit="VA") "Simlified Power measurements";
        equation
          for i in 1:grid.nLinks loop
            connect(lines[i].terminal_p, terminal[grid.fromTo[i,1]]);
            connect(lines[i].terminal_n, terminal[grid.fromTo[i,2]]);
          end for;

          for i in 1:grid.nNodes loop
            VAbs[1,i] = Buildings.Electrical.PhaseSystems.OnePhase.systemVoltage(terminal[i].phase[1].v);
            VAbs[2,i] = Buildings.Electrical.PhaseSystems.OnePhase.systemVoltage(terminal[i].phase[2].v);
            VAbs[3,i] = Buildings.Electrical.PhaseSystems.OnePhase.systemVoltage(terminal[i].phase[3].v);
            for ph in 1:3 loop
              Vpu[ph,i] = VAbs[ph,i] / V_nominal;
              S_temp[ph,i,1:2] = Buildings.Electrical.PhaseSystems.OnePhase.phasePowers_vi(v=terminal[i].phase[ph].v, i=terminal[i].phase[ph].i);
              P[ph,i] = S_temp[ph,i,1];
              Q[ph,i] = S_temp[ph,i,2];
            end for;
          end for;
          annotation (
          defaultComponentName="net",
         Documentation(revisions="<html>
 <ul>
 <li>
March 30, 2015, by Michael Wetter:<br/>
Made <code>network</code> replaceable. This was detected
by the OpenModelica regression tests.
</li>
<li>
October 6, 2014, by Marco Bonvini:<br/>
Revised documentation and model.
</li>
</ul>
</html>",         info="<html>
<p>
This model represents a generalized electrical AC three-phase unbalanced network
without neutral cable.
</p>
<p>
See <a href=\"modelica://Buildings.Electrical.Transmission.BaseClasses.PartialNetwork\">
Buildings.Electrical.Transmission.BaseClasses.PartialNetwork</a>
for information about the network model.
</p>
<p>
See <a href=\"modelica://Buildings.Electrical.Transmission.Grids.PartialGrid\">
Buildings.Electrical.Transmission.Grids.PartialGrid</a>
for more information about the topology of the network, such as
the number of nodes, how they are connected, and the length of each connection.
</p>
</html>"));
        end Network;

        model Line "Model of an electrical line without neutral cable"
          extends
            Buildings.Electrical.AC.ThreePhasesUnbalanced.Interfaces.TwoPort;
          extends Buildings.Electrical.Transmission.BaseClasses.PartialBaseLine(
          V_nominal(start = 480),
          commercialCable = Buildings.Electrical.Transmission.Functions.selectCable_low(P_nominal, V_nominal));
          Buildings.Electrical.AC.OnePhase.Lines.TwoPortRL phase1(
            final useHeatPort=true,
            final T_ref=T_ref,
            final M=M,
            final R=R/3,
            final L=L/3,
            final mode=modelMode) "Impedance line 1"
            annotation (Placement(transformation(extent={{-10,20},{10,40}})));
          Buildings.Electrical.AC.OnePhase.Lines.TwoPortRL phase2(
            final useHeatPort=true,
            final T_ref=T_ref,
            final M=M,
            final R=R/3,
            final L=L/3,
            final mode=modelMode) "Impedance line 2"
            annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
          Buildings.Electrical.AC.OnePhase.Lines.TwoPortRL phase3(
            final useHeatPort=true,
            final T_ref=T_ref,
            final M=M,
            final R=R/3,
            final L=L/3,
            final mode=modelMode) "Impedance line 3"
            annotation (Placement(transformation(extent={{-10,-40},{10,-20}})));
          Real P[3](each unit="W") "Phase Active Power";
          Real Q[3](each unit="var") "Phase Reactive Power";
          Real S_temp[3,2](each unit="VA") "Simlified Power measurements";
        equation
          for ph in 1:3 loop
            S_temp[ph,1:2] = Buildings.Electrical.PhaseSystems.OnePhase.phasePowers_vi(v=terminal_p.phase[ph].v, i=terminal_p.phase[ph].i);
            P[ph] = S_temp[ph,1];
            Q[ph] = S_temp[ph,2];
          end for;

          connect(cableTemp.port, phase1.heatPort) annotation (Line(
              points={{-40,22},{-26,22},{-26,10},{6.66134e-16,10},{6.66134e-16,20}},
              color={191,0,0},
              smooth=Smooth.None));
          connect(cableTemp.port, phase2.heatPort) annotation (Line(
              points={{-40,22},{-26,22},{-26,-20},{0,-20},{0,-10},{4.44089e-16,-10}},
              color={191,0,0},
              smooth=Smooth.None));
          connect(cableTemp.port, phase3.heatPort) annotation (Line(
              points={{-40,22},{-26,22},{-26,-50},{0,-50},{0,-40}},
              color={191,0,0},
              smooth=Smooth.None));
          connect(terminal_n.phase[1], phase1.terminal_n) annotation (Line(
              points={{-99.95,0.05},{-20,0.05},{-20,30},{-10,30}},
              color={0,120,120},
              smooth=Smooth.None));
          connect(terminal_n.phase[2], phase2.terminal_n) annotation (Line(
              points={{-99.95,0.05},{-54,0.05},{-54,0},{-10,0}},
              color={0,120,120},
              smooth=Smooth.None));
          connect(terminal_n.phase[3], phase3.terminal_n) annotation (Line(
              points={{-99.95,0.05},{-20,0.05},{-20,-30},{-10,-30}},
              color={0,120,120},
              smooth=Smooth.None));
          connect(phase1.terminal_p, terminal_p.phase[1]) annotation (Line(
              points={{10,30},{20,30},{20,0.05},{100.05,0.05}},
              color={0,120,120},
              smooth=Smooth.None));
          connect(phase2.terminal_p, terminal_p.phase[2]) annotation (Line(
              points={{10,0},{56,0},{56,0.05},{100.05,0.05}},
              color={0,120,120},
              smooth=Smooth.None));
          connect(phase3.terminal_p, terminal_p.phase[3]) annotation (Line(
              points={{10,-30},{20,-30},{20,0.05},{100.05,0.05}},
              color={0,120,120},
              smooth=Smooth.None));
          annotation (
          defaultComponentName="line",
         Icon(graphics={
                Ellipse(
                  extent={{-70,10},{-50,-10}},
                  lineColor={0,0,0},
                  fillColor={11,193,87},
                  fillPattern=FillPattern.Solid),
                Rectangle(
                  extent={{-60,10},{60,-10}},
                  fillColor={11,193,87},
                  fillPattern=FillPattern.Solid,
                  pattern=LinePattern.None,
                  lineColor={0,0,0}),
                Ellipse(
                  extent={{50,10},{70,-10}},
                  lineColor={0,0,0},
                  fillColor={255,128,0},
                  fillPattern=FillPattern.Solid),
                Line(
                  points={{-70,0},{-90,0}},
                  color={0,0,0},
                  smooth=Smooth.None),
                Line(
                  points={{-60,10},{60,10}},
                  color={0,0,0},
                  smooth=Smooth.None),
                Line(
                  points={{-60,-10},{60,-10}},
                  color={0,0,0},
                  smooth=Smooth.None),
                Line(
                  points={{96,0},{60,0}},
                  color={0,0,0},
                  smooth=Smooth.None)}),
            Documentation(revisions="<html>
<ul>
<li>
October 6, 2014, by Marco Bonvini:<br/>
Revised documentation and model.
</li>
</ul>
</html>",         info="<html>
<p>
This model represents an AC three-phase unbalanced cable without
neutral connection. The model is based on
<a href=\"Buildings.Electrical.AC.ThreePhasesUnbalanced.Lines.TwoPortRLC\">
Buildings.Electrical.AC.ThreePhasesUnbalanced.Lines.TwoPortRLC</a>
and provides functionalities to parametrize the values of <i>R</i>, <i>L</i> and <i>C</i>
using either commercial cables or default values.
</p>
</html>"));
        end Line;

        model IEEE13_extBus

          Model.Network ieee13(                  redeclare Records.IEEE_13 grid,
              V_nominal=4.16e3/sqrt(3))
            annotation (Placement(transformation(
                extent={{-10,10},{10,-10}},
                rotation=270,
                origin={0,90})));
          Inverter.Model.SpotLoad_Y_PQ_extBus
                                       node3
                  annotation (Placement(transformation(
                extent={{-10,-10},{10,10}},
                rotation=90,
                origin={-50,50})));
          Inverter.Model.SpotLoad_D_PQ_extBus
                                       node4
                  annotation (Placement(transformation(
                extent={{-10,-10},{10,10}},
                rotation=90,
                origin={-90,50})));
          Inverter.Model.SpotLoad_Y_PQ_extBus
                                       node2
                     annotation (Placement(transformation(extent={{-20,20},{0,40}})));
          Inverter.Model.SpotLoad_Y_PQ_extBus
                                       node6
                     annotation (Placement(transformation(
                extent={{-10,-10},{10,10}},
                rotation=90,
                origin={90,50})));
          Inverter.Model.SpotLoad_Y_PQ_extBus
                                       node11
                      annotation (Placement(transformation(
                extent={{-10,-10},{10,10}},
                rotation=90,
                origin={90,-10})));
          Inverter.Model.SpotLoad_D_PQ_extBus
                                       node10
                      annotation (Placement(transformation(
                extent={{-10,-10},{10,10}},
                rotation=90,
                origin={40,-10})));
          Inverter.Model.SpotLoad_D_PQ_extBus
                                       node7
                      annotation (Placement(transformation(extent={{-20,-40},{0,-20}})));
          Inverter.Model.SpotLoad_Y_PQ_extBus
                                       node9
                     annotation (Placement(transformation(
                extent={{-10,-10},{10,10}},
                rotation=90,
                origin={-90,-10})));
          Inverter.Model.SpotLoad_Y_PQ_extBus
                                       node12
                  annotation (Placement(transformation(extent={{-60,-90},{-40,-70}})));
          Buildings.Electrical.AC.ThreePhasesUnbalanced.Sources.Grid node1(f=60, V=4.16e3)
            annotation (Placement(transformation(extent={{-60,80},{-40,100}})));
          Inverter.Interfaces.LoadCtrlBus ctrlNode4 annotation (Placement(
                transformation(extent={{-110,4},{-90,24}}), iconTransformation(extent={
                    {-140,6},{-120,26}})));
          Inverter.Interfaces.LoadCtrlBus ctrlNode2 annotation (Placement(
                transformation(extent={{-110,24},{-90,44}}), iconTransformation(extent=
                    {{-140,6},{-120,26}})));
          Inverter.Interfaces.LoadCtrlBus ctrlNode3 annotation (Placement(
                transformation(extent={{-110,14},{-90,34}}), iconTransformation(extent=
                    {{-140,6},{-120,26}})));
          Inverter.Interfaces.LoadCtrlBus ctrlNode6 annotation (Placement(
                transformation(extent={{-110,-6},{-90,14}}), iconTransformation(extent=
                    {{-140,6},{-120,26}})));
          Inverter.Interfaces.LoadCtrlBus ctrlNode7 annotation (Placement(
                transformation(extent={{-110,-50},{-90,-30}}), iconTransformation(
                  extent={{-140,6},{-120,26}})));
          Inverter.Interfaces.LoadCtrlBus ctrlNode9 annotation (Placement(
                transformation(extent={{-110,-40},{-90,-20}}), iconTransformation(
                  extent={{-140,6},{-120,26}})));
          Inverter.Interfaces.LoadCtrlBus ctrlNode10 annotation (Placement(
                transformation(extent={{-110,-60},{-90,-40}}), iconTransformation(
                  extent={{-140,6},{-120,26}})));
          Inverter.Interfaces.LoadCtrlBus ctrlNode11 annotation (Placement(
                transformation(extent={{-110,-70},{-90,-50}}), iconTransformation(
                  extent={{-140,6},{-120,26}})));
          Inverter.Interfaces.LoadCtrlBus ctrlNode12 annotation (Placement(
                transformation(extent={{-110,-80},{-90,-60}}), iconTransformation(
                  extent={{-140,6},{-120,26}})));
          Inverter.Model.SpotLoad_Y_PQ_extBus node13
            annotation (Placement(transformation(extent={{-20,-90},{0,-70}})));
          Inverter.Interfaces.LoadCtrlBus ctrlNode13 annotation (Placement(
                transformation(extent={{-110,-90},{-90,-70}}), iconTransformation(
                  extent={{-140,6},{-120,26}})));
        equation
          connect(node4.terminal_n, ieee13.terminal[4]) annotation (Line(points={{-90,60},
                  {0,60},{0,80},{-1.77636e-015,80}},     color={0,120,120}));
          connect(node3.terminal_n, ieee13.terminal[3]) annotation (Line(points={{-50,
                  60},{0,60},{0,80},{-1.77636e-015,80}}, color={0,120,120}));
          connect(node6.terminal_n, ieee13.terminal[6]) annotation (Line(points={{90,60},
                  {46,60},{0,60},{0,80}}, color={0,120,120}));
          connect(node2.terminal_n, ieee13.terminal[2])
            annotation (Line(points={{0,30},{0,30},{0,80}}, color={0,120,120}));
          connect(node7.terminal_n, ieee13.terminal[7])
            annotation (Line(points={{0,-30},{0,-30},{0,80}}, color={0,120,120}));
          connect(node9.terminal_n, ieee13.terminal[9]) annotation (Line(points={{-90,0},
                  {0,0},{0,80},{-1.77636e-015,80}}, color={0,120,120}));
          connect(node12.terminal_n, ieee13.terminal[12]) annotation (Line(points={{-40,-80},
                  {-40,-80},{-40,0},{0,0},{0,80}},      color={0,120,120}));
          connect(node10.terminal_n, ieee13.terminal[10]) annotation (Line(points={{40,
                  0},{0,0},{0,80},{-1.77636e-015,80}}, color={0,120,120}));
          connect(node11.terminal_n, ieee13.terminal[11])
            annotation (Line(points={{90,0},{0,0},{0,80}}, color={0,120,120}));
          connect(node1.terminal, ieee13.terminal[1])
            annotation (Line(points={{-50,80},{-26,80},{0,80}}, color={0,120,120}));
          connect(node12.ctrls, ctrlNode12) annotation (Line(
              points={{-60,-80},{-60,-80},{-70,-80},{-70,-70},{-100,-70}},
              color={255,204,51},
              thickness=0.5), Text(
              string="%second",
              index=1,
              extent={{6,3},{6,3}}));
          connect(ctrlNode11, node11.ctrls) annotation (Line(
              points={{-100,-60},{90,-60},{90,-20}},
              color={255,204,51},
              thickness=0.5), Text(
              string="%first",
              index=-1,
              extent={{-6,3},{-6,3}}));
          connect(ctrlNode10, node10.ctrls) annotation (Line(
              points={{-100,-50},{40,-50},{40,-20}},
              color={255,204,51},
              thickness=0.5), Text(
              string="%first",
              index=-1,
              extent={{-6,3},{-6,3}}));
          connect(node9.ctrls, ctrlNode9) annotation (Line(
              points={{-90,-20},{-90,-20},{-90,-30},{-100,-30}},
              color={255,204,51},
              thickness=0.5), Text(
              string="%second",
              index=1,
              extent={{6,3},{6,3}}));
          connect(ctrlNode7, node7.ctrls) annotation (Line(
              points={{-100,-40},{-60,-40},{-60,-30},{-20,-30}},
              color={255,204,51},
              thickness=0.5), Text(
              string="%first",
              index=-1,
              extent={{-6,3},{-6,3}}));
          connect(ctrlNode6, node6.ctrls) annotation (Line(
              points={{-100,4},{90,4},{90,40}},
              color={255,204,51},
              thickness=0.5), Text(
              string="%first",
              index=-1,
              extent={{-6,3},{-6,3}}));
          connect(ctrlNode2, node2.ctrls) annotation (Line(
              points={{-100,34},{-60,34},{-60,30},{-20,30}},
              color={255,204,51},
              thickness=0.5), Text(
              string="%first",
              index=-1,
              extent={{-6,3},{-6,3}}));
          connect(ctrlNode3, node3.ctrls) annotation (Line(
              points={{-100,24},{-50,24},{-50,40},{-50,40}},
              color={255,204,51},
              thickness=0.5), Text(
              string="%first",
              index=-1,
              extent={{-6,3},{-6,3}}));
          connect(ctrlNode4, node4.ctrls) annotation (Line(
              points={{-100,14},{-90,14},{-90,40}},
              color={255,204,51},
              thickness=0.5), Text(
              string="%first",
              index=-1,
              extent={{-6,3},{-6,3}}));
          connect(node13.terminal_n, ieee13.terminal[13])
            annotation (Line(points={{0,-80},{0,80},{0,80}}, color={0,120,120}));
          connect(node13.ctrls, ctrlNode13) annotation (Line(
              points={{-20,-80},{-28,-80},{-28,-94},{-80,-94},{-80,-80},{-100,-80}},
              color={255,204,51},
              thickness=0.5), Text(
              string="%second",
              index=1,
              extent={{6,3},{6,3}}));
          annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
                coordinateSystem(preserveAspectRatio=false)));
        end IEEE13_extBus;
      end Model;

      package Examples
        model Test_IEEE13

          Model.Network ieee13(                  redeclare Records.IEEE_13 grid,
              V_nominal=4.16e3/sqrt(3))
            annotation (Placement(transformation(
                extent={{-10,10},{10,-10}},
                rotation=270,
                origin={0,90})));
          Inverter.Model.SpotLoad_Y_PQ node3(
            P1=0,
            Q1=0,
            P2=170e3,
            Q2=125e3,
            P3=0,
            Q3=0) annotation (Placement(transformation(
                extent={{-10,-10},{10,10}},
                rotation=90,
                origin={-50,50})));
          Inverter.Model.SpotLoad_D_PQ node4(
            P1=0,
            Q1=0,
            P2=230e3,
            Q2=132e3,
            P3=0,
            Q3=0) annotation (Placement(transformation(
                extent={{-10,-10},{10,10}},
                rotation=90,
                origin={-90,50})));
          Inverter.Model.SpotLoad_Y_PQ node2(
            P1=17e3,
            Q1=10e3,
            P2=66e3,
            Q2=38e3,
            P3=117e3,
            Q3=68e3) annotation (Placement(transformation(extent={{-20,20},{0,40}})));
          Inverter.Model.SpotLoad_Y_PQ node6(
            P1=160e3,
            Q1=110e3,
            P2=120e3,
            Q2=90e3,
            P3=120e3,
            Q3=90e3) annotation (Placement(transformation(
                extent={{-10,-10},{10,10}},
                rotation=90,
                origin={90,50})));
          Inverter.Model.SpotLoad_Y_PQ node11(
            P1=485e3,
            Q1=190e3,
            P2=68e3,
            Q2=60e3,
            P3=290e3,
            Q3=212e3) annotation (Placement(transformation(
                extent={{-10,-10},{10,10}},
                rotation=90,
                origin={90,-10})));
          Inverter.Model.SpotLoad_D_PQ node10(
            P1=0,
            Q1=0,
            P2=0,
            Q2=0,
            P3=170e3,
            Q3=151e3) annotation (Placement(transformation(
                extent={{-10,-10},{10,10}},
                rotation=90,
                origin={40,-10})));
          Inverter.Model.SpotLoad_D_PQ node7(
            P1=385e3,
            Q1=220e3,
            P2=385e3,
            Q2=220e3,
            P3=385e3,
            Q3=220e3) annotation (Placement(transformation(extent={{-20,-40},{0,-20}})));
          Inverter.Model.SpotLoad_Y_PQ node9(
            P1=0,
            Q1=0,
            P2=0,
            Q2=0,
            P3=170e3,
            Q3=80e3) annotation (Placement(transformation(
                extent={{-10,-10},{10,10}},
                rotation=90,
                origin={-90,-10})));
          Inverter.Model.SpotLoad_Y_PQ node12(
            P1=128e3,
            Q1=86e3,
            P2=0,
            Q2=0,
            P3=0,
            Q3=0) annotation (Placement(transformation(extent={{-60,-80},{-40,-60}})));
          Buildings.Electrical.AC.ThreePhasesUnbalanced.Sources.Grid node1(f=60, V=4.16e3)
            annotation (Placement(transformation(extent={{-60,80},{-40,100}})));
        equation
          connect(node4.terminal_n, ieee13.terminal[4]) annotation (Line(points={{-90,
                  60},{0,60},{0,80},{-1.77636e-015,80}}, color={0,120,120}));
          connect(node3.terminal_n, ieee13.terminal[3]) annotation (Line(points={{-50,
                  60},{0,60},{0,80},{-1.77636e-015,80}}, color={0,120,120}));
          connect(node6.terminal_n, ieee13.terminal[6]) annotation (Line(points={{90,60},
                  {46,60},{0,60},{0,80}}, color={0,120,120}));
          connect(node2.terminal_n, ieee13.terminal[2])
            annotation (Line(points={{0,30},{0,30},{0,80}}, color={0,120,120}));
          connect(node7.terminal_n, ieee13.terminal[7])
            annotation (Line(points={{0,-30},{0,-30},{0,80}}, color={0,120,120}));
          connect(node9.terminal_n, ieee13.terminal[9]) annotation (Line(points={{-90,0},
                  {0,0},{0,80},{-1.77636e-015,80}}, color={0,120,120}));
          connect(node12.terminal_n, ieee13.terminal[12]) annotation (Line(points={{-40,
                  -70},{-40,-70},{-40,0},{0,0},{0,80}}, color={0,120,120}));
          connect(node10.terminal_n, ieee13.terminal[10]) annotation (Line(points={{40,
                  0},{0,0},{0,80},{-1.77636e-015,80}}, color={0,120,120}));
          connect(node11.terminal_n, ieee13.terminal[11])
            annotation (Line(points={{90,0},{0,0},{0,80}}, color={0,120,120}));
          connect(node1.terminal, ieee13.terminal[1])
            annotation (Line(points={{-50,80},{-26,80},{0,80}}, color={0,120,120}));
          annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
                coordinateSystem(preserveAspectRatio=false)));
        end Test_IEEE13;
      end Examples;

      package Records
        record IEEE_13 "Grid model inspired to the IEEE 13 Node test feeder"
          extends Buildings.Electrical.Transmission.Grids.PartialGrid(
            nNodes = 13,
            nLinks = 12,
            l = [610;150;90;150;90;610;90;90;90;150;240;300],
            fromTo = [[1,2]; [2,3]; [3,4]; [2,5]; [5,6]; [2,7]; [7,8]; [8,9]; [7,10]; [10,11]; [
                      8,12]; [7,13]],
            redeclare Buildings.Electrical.Transmission.LowVoltageCables.Generic cables=
               {Buildings.Electrical.Transmission.LowVoltageCables.PvcAl120(),
                Buildings.Electrical.Transmission.LowVoltageCables.PvcAl70(),
                Buildings.Electrical.Transmission.LowVoltageCables.PvcAl35(),
                Buildings.Electrical.Transmission.LowVoltageCables.PvcAl70(),
                Buildings.Electrical.Transmission.LowVoltageCables.PvcAl35(),
                Buildings.Electrical.Transmission.LowVoltageCables.PvcAl120(),
                Buildings.Electrical.Transmission.LowVoltageCables.PvcAl70(),
                Buildings.Electrical.Transmission.LowVoltageCables.PvcAl35(),
                Buildings.Electrical.Transmission.LowVoltageCables.PvcAl70(),
                Buildings.Electrical.Transmission.LowVoltageCables.PvcAl35(),
                Buildings.Electrical.Transmission.LowVoltageCables.PvcAl35(),
                Buildings.Electrical.Transmission.LowVoltageCables.PvcAl35()});

          annotation (Documentation);
        end IEEE_13;
      end Records;
    end Grid;

    package uPMU

      package Model
        model uPMUInput
          parameter Real V_nominal(unit="V", start=120) = 120;
          Components.Inverter.Model.InverterLoad_PQ PQ_inverterLoad(V_start=V_nominal)
            annotation (Placement(transformation(extent={{40,-10},{20,10}})));
          Modelica.Blocks.Interfaces.RealInput Q(unit="var") "Reactive Power Input"
            annotation (Placement(transformation(
                extent={{20,-20},{-20,20}},
                rotation=180,
                origin={-120,-40}), iconTransformation(
                extent={{20,-20},{-20,20}},
                rotation=180,
                origin={-120,-40})));
          Modelica.Blocks.Interfaces.RealInput P(unit="W") "Active Power Input"
            annotation (Placement(transformation(
                extent={{20,-20},{-20,20}},
                rotation=180,
                origin={-120,40}), iconTransformation(
                extent={{20,-20},{-20,20}},
                rotation=180,
                origin={-120,40})));
          Buildings.Electrical.AC.OnePhase.Interfaces.Terminal_n term_p
            annotation (Placement(transformation(extent={{90,-10},{110,10}}),
                iconTransformation(extent={{90,-10},{110,10}})));
        equation

          connect(P, PQ_inverterLoad.Pow) annotation (Line(points={{-120,40},{-60,40},{-60,
                  0},{18,0}}, color={0,0,127}));
          connect(PQ_inverterLoad.terminal, term_p)
            annotation (Line(points={{40,0},{100,0}}, color={0,120,120}));
          connect(PQ_inverterLoad.Q, Q) annotation (Line(points={{18,6},{0,6},{0,-40},{-120,
                  -40}}, color={0,0,127}));
          annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
                coordinateSystem(preserveAspectRatio=false)));
        end uPMUInput;

        model uPMUSource_1ph "Voltage reference from uPMU"
          extends Buildings.Electrical.Interfaces.Source(
            redeclare package PhaseSystem =
              Buildings.Electrical.PhaseSystems.OnePhase,
            redeclare replaceable Buildings.Electrical.AC.OnePhase.Interfaces.Terminal_p terminal);
          parameter Modelica.SIunits.Angle phiSou = 0 "Phase shift of the source";
        protected
          Modelica.SIunits.Angle thetaRel
            "Absolute angle of rotating system as offset to thetaRef";
        public
          Modelica.Blocks.Interfaces.RealInput V(unit="V", start=120)
            "RMS voltage of the source" annotation (Placement(transformation(
                extent={{20,-20},{-20,20}},
                rotation=180,
                origin={-120,40}), iconTransformation(
                extent={{20,-20},{-20,20}},
                rotation=180,
                origin={-120,40})));
          Modelica.Blocks.Interfaces.RealInput f(unit="Hz", start=60) "Frequency of the source"
            annotation (Placement(transformation(
                extent={{20,-20},{-20,20}},
                rotation=180,
                origin={-120,-40}), iconTransformation(
                extent={{20,-20},{-20,20}},
                rotation=180,
                origin={-120,-40})));
        equation
          if Connections.isRoot(terminal.theta) then
            PhaseSystem.thetaRef(terminal.theta) =  2*Modelica.Constants.pi*f*time;
          end if;
          thetaRel = PhaseSystem.thetaRel(terminal.theta);
          terminal.v = PhaseSystem.phaseVoltages(V, thetaRel + phiSou);

          annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
                coordinateSystem(preserveAspectRatio=false)));
        end uPMUSource_1ph;

        model uPMUSource_3ph "Voltage reference from uPMU"
          extends
            Buildings.Electrical.AC.ThreePhasesUnbalanced.Sources.BaseClasses.PartialSource;
          constant Modelica.SIunits.Angle angle120 = 2*Modelica.Constants.pi/3 "Phase shift between the phase voltages";
          Buildings.Electrical.AC.ThreePhasesUnbalanced.Interfaces.Adapter3to3 ada "Adapter between the different connectors" annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
          uPMUSource_1ph phase1(phiSou=0) annotation (Placement(transformation(extent={{-60,50},{-40,70}})));
          uPMUSource_1ph phase2(phiSou=angle120) annotation (Placement(transformation(extent={{-60,-10},{-40,10}})));
          uPMUSource_1ph phase3(phiSou=2*angle120) annotation (Placement(transformation(extent={{-60,-70},{-40,-50}})));
          Modelica.Blocks.Interfaces.RealInput V1(unit="V", start=120) "RMS voltage of the source" annotation (Placement(transformation(
                extent={{20,-20},{-20,20}},
                rotation=180,
                origin={-120,70}), iconTransformation(
                extent={{10,-10},{-10,10}},
                rotation=180,
                origin={-110,90})));
          Modelica.Blocks.Interfaces.RealInput f1(unit="Hz", start=60) "Frequency of the source" annotation (Placement(transformation(
                extent={{20,-20},{-20,20}},
                rotation=180,
                origin={-120,50}), iconTransformation(
                extent={{10,-10},{-10,10}},
                rotation=180,
                origin={-110,70})));
          Modelica.Blocks.Interfaces.RealInput V2(unit="V", start=120) "RMS voltage of the source" annotation (Placement(transformation(
                extent={{20,-20},{-20,20}},
                rotation=180,
                origin={-120,10}), iconTransformation(
                extent={{10,-10},{-10,10}},
                rotation=180,
                origin={-110,30})));
          Modelica.Blocks.Interfaces.RealInput f2(unit="Hz", start=60) "Frequency of the source" annotation (Placement(transformation(
                extent={{20,-20},{-20,20}},
                rotation=180,
                origin={-120,-10}),iconTransformation(
                extent={{10,-10},{-10,10}},
                rotation=180,
                origin={-110,10})));
          Modelica.Blocks.Interfaces.RealInput V3(unit="V", start=120) "RMS voltage of the source" annotation (Placement(transformation(
                extent={{20,-20},{-20,20}},
                rotation=180,
                origin={-120,-50}),iconTransformation(
                extent={{10,-10},{-10,10}},
                rotation=180,
                origin={-110,-30})));
          Modelica.Blocks.Interfaces.RealInput f3(unit="Hz", start=60) "Frequency of the source" annotation (Placement(transformation(
                extent={{20,-20},{-20,20}},
                rotation=180,
                origin={-120,-70}),iconTransformation(
                extent={{10,-10},{-10,10}},
                rotation=180,
                origin={-110,-50})));
        equation

          connect(ada.terminal, connection3to4.terminal4)
            annotation (Line(points={{10,0},{25,0},{40,0}}, color={0,120,120}));
          connect(phase1.terminal, ada.terminals[1]) annotation (Line(points={{-40,60},{
                  -26,60},{-26,0.533333},{-9.8,0.533333}}, color={0,120,120}));
          connect(phase2.terminal, ada.terminals[2])
            annotation (Line(points={{-40,0},{-9.8,0}}, color={0,120,120}));
          connect(phase3.terminal, ada.terminals[3]) annotation (Line(points={{-40,-60},
                  {-26,-60},{-26,-0.533333},{-9.8,-0.533333}}, color={0,120,120}));
          connect(V1, phase1.V) annotation (Line(points={{-120,70},{-92,70},{-92,64},{-62,
                  64}}, color={0,0,127}));
          connect(f1, phase1.f) annotation (Line(points={{-120,50},{-92,50},{-92,56},{-62,
                  56}}, color={0,0,127}));
          connect(V2, phase2.V) annotation (Line(points={{-120,10},{-92,10},{-92,4},{-62,
                  4}}, color={0,0,127}));
          connect(f2, phase2.f) annotation (Line(points={{-120,-10},{-92,-10},{-92,-4},
                {-62,-4}},  color={0,0,127}));
          connect(V3, phase3.V) annotation (Line(points={{-120,-50},{-92,-50},{-92,-56},
                  {-62,-56}}, color={0,0,127}));
          connect(f3, phase3.f) annotation (Line(points={{-120,-70},{-91,-70},{-91,-64},
                  {-62,-64}}, color={0,0,127}));
        end uPMUSource_3ph;
      end Model;

      package Examples
        extends Modelica.Icons.ExamplesPackage;

        model Test_uPMUInput

          Buildings.Electrical.AC.ThreePhasesUnbalanced.Interfaces.Adapter3to3 ada_1
            annotation (Placement(transformation(extent={{20,-10},{40,10}})));
          Components.Sensor.Model.Probe3ph sens_all
            annotation (Placement(transformation(extent={{70,-10},{50,10}})));
          Buildings.Electrical.AC.OnePhase.Sensors.GeneralizedSensor sens2
            annotation (Placement(transformation(
                extent={{-10,10},{10,-10}},
                rotation=180,
                origin={-10,0})));
          Buildings.Electrical.AC.ThreePhasesUnbalanced.Sources.FixedVoltage source(f=60, V=
                208)
            annotation (Placement(transformation(extent={{-10,-10},{10,10}},
                rotation=180,
                origin={90,0})));
          Model.uPMUInput uPMUInput
            annotation (Placement(transformation(extent={{-60,-10},{-40,10}})));
          Modelica.Blocks.Sources.Sine P(
            freqHz=1,
            phase=0,
            offset=0,
            amplitude=1000)
            annotation (Placement(transformation(extent={{-100,10},{-80,30}})));
          Modelica.Blocks.Sources.Sine Q(
            phase=0,
            offset=0,
            freqHz=0.5,
            amplitude=1000)
            annotation (Placement(transformation(extent={{-100,-30},{-80,-10}})));
          Buildings.Electrical.AC.OnePhase.Sensors.GeneralizedSensor sens1
            annotation (Placement(transformation(
                extent={{10,10},{-10,-10}},
                rotation=180,
                origin={-10,40})));
          Buildings.Electrical.AC.OnePhase.Sensors.GeneralizedSensor sens3
            annotation (Placement(transformation(
                extent={{10,10},{-10,-10}},
                rotation=180,
                origin={-10,-40})));
          Buildings.Electrical.AC.OnePhase.Loads.Resistive loa
            annotation (Placement(transformation(extent={{-20,30},{-40,50}})));
          Buildings.Electrical.AC.OnePhase.Loads.Resistive loa1
            annotation (Placement(transformation(extent={{-20,-50},{-40,-30}})));
        equation
          connect(uPMUInput.P, P.y) annotation (Line(points={{-62,4},{-70,4},{-70,
                  20},{-79,20}}, color={0,0,127}));
          connect(uPMUInput.Q, Q.y) annotation (Line(points={{-62,-4},{-70,-4},{
                  -70,-20},{-79,-20}}, color={0,0,127}));
          connect(sens1.terminal_p, ada_1.terminals[1]) annotation (Line(points={
                  {0,40},{10,40},{10,0.533333},{20.2,0.533333}}, color={0,120,120}));
          connect(sens3.terminal_p, ada_1.terminals[3]) annotation (Line(points={
                  {0,-40},{10,-40},{10,-0.533333},{20.2,-0.533333}}, color={0,120,
                  120}));
          connect(sens1.terminal_n, loa.terminal)
            annotation (Line(points={{-20,40},{-20,40}}, color={0,120,120}));
          connect(sens3.terminal_n, loa1.terminal)
            annotation (Line(points={{-20,-40},{-20,-40}}, color={0,120,120}));
          connect(sens_all.terminal_n, source.terminal)
            annotation (Line(points={{70,0},{80,0}}, color={0,120,120}));
          connect(sens_all.terminal_p, ada_1.terminal)
            annotation (Line(points={{50,0},{40,0}}, color={0,120,120}));
          connect(sens2.terminal_p, uPMUInput.term_p)
            annotation (Line(points={{-20,0},{-40,0}}, color={0,120,120}));
          connect(sens2.terminal_n, ada_1.terminals[2])
            annotation (Line(points={{0,0},{20.2,0}}, color={0,120,120}));
          annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
                coordinateSystem(preserveAspectRatio=false)));
        end Test_uPMUInput;

        model Test_uPMUInput_FMU

          Buildings.Electrical.AC.ThreePhasesUnbalanced.Interfaces.Adapter3to3 ada_1
            annotation (Placement(transformation(extent={{20,-10},{40,10}})));
          Components.Sensor.Model.Probe3ph sens_all
            annotation (Placement(transformation(extent={{70,-10},{50,10}})));
          Buildings.Electrical.AC.OnePhase.Sensors.GeneralizedSensor sens2
            annotation (Placement(transformation(
                extent={{-10,10},{10,-10}},
                rotation=180,
                origin={-10,0})));
          Buildings.Electrical.AC.ThreePhasesUnbalanced.Sources.FixedVoltage source(f=60, V=
                208)
            annotation (Placement(transformation(extent={{-10,-10},{10,10}},
                rotation=180,
                origin={90,0})));
          Model.uPMUInput uPMUInput
            annotation (Placement(transformation(extent={{-60,-10},{-40,10}})));
          Buildings.Electrical.AC.OnePhase.Sensors.GeneralizedSensor sens1
            annotation (Placement(transformation(
                extent={{10,10},{-10,-10}},
                rotation=180,
                origin={-10,40})));
          Buildings.Electrical.AC.OnePhase.Sensors.GeneralizedSensor sens3
            annotation (Placement(transformation(
                extent={{10,10},{-10,-10}},
                rotation=180,
                origin={-10,-40})));
          Buildings.Electrical.AC.OnePhase.Loads.Resistive loa
            annotation (Placement(transformation(extent={{-20,30},{-40,50}})));
          Buildings.Electrical.AC.OnePhase.Loads.Resistive loa1
            annotation (Placement(transformation(extent={{-20,-50},{-40,-30}})));
          Modelica.Blocks.Interfaces.RealInput Q(unit="var") "Reactive Power Input"
            annotation (Placement(transformation(
                extent={{20,-20},{-20,20}},
                rotation=180,
                origin={-120,-40}), iconTransformation(
                extent={{20,-20},{-20,20}},
                rotation=180,
                origin={-120,-40})));
          Modelica.Blocks.Interfaces.RealInput P(unit="W") "Active Power Input"
            annotation (Placement(transformation(
                extent={{20,-20},{-20,20}},
                rotation=180,
                origin={-120,40}), iconTransformation(
                extent={{20,-20},{-20,20}},
                rotation=180,
                origin={-120,40})));
        equation
          connect(sens1.terminal_p, ada_1.terminals[1]) annotation (Line(points={
                  {0,40},{10,40},{10,0.533333},{20.2,0.533333}}, color={0,120,120}));
          connect(sens3.terminal_p, ada_1.terminals[3]) annotation (Line(points={
                  {0,-40},{10,-40},{10,-0.533333},{20.2,-0.533333}}, color={0,120,
                  120}));
          connect(sens1.terminal_n, loa.terminal)
            annotation (Line(points={{-20,40},{-20,40}}, color={0,120,120}));
          connect(sens3.terminal_n, loa1.terminal)
            annotation (Line(points={{-20,-40},{-20,-40}}, color={0,120,120}));
          connect(uPMUInput.P, P) annotation (Line(points={{-62,4},{-80,4},{-80,
                  40},{-120,40}}, color={0,0,127}));
          connect(uPMUInput.Q, Q) annotation (Line(points={{-62,-4},{-80,-4},{-80,
                  -40},{-120,-40}}, color={0,0,127}));
          connect(sens_all.terminal_n, source.terminal)
            annotation (Line(points={{70,0},{80,0}}, color={0,120,120}));
          connect(sens_all.terminal_p, ada_1.terminal)
            annotation (Line(points={{50,0},{40,0}}, color={0,120,120}));
          connect(sens2.terminal_p, uPMUInput.term_p)
            annotation (Line(points={{-20,0},{-40,0}}, color={0,120,120}));
          connect(sens2.terminal_n, ada_1.terminals[2])
            annotation (Line(points={{0,0},{20.2,0}}, color={0,120,120}));
          annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
                coordinateSystem(preserveAspectRatio=false)));
        end Test_uPMUInput_FMU;

        model Test_uPMUSource

          Model.uPMUSource_1ph
                           uPMUSource
            annotation (Placement(transformation(extent={{-60,60},{-40,80}})));
          Model.uPMUInput uPMUInput
            annotation (Placement(transformation(extent={{60,60},{40,80}})));
          Buildings.Electrical.AC.OnePhase.Sensors.GeneralizedSensor sens_1ph
            annotation (Placement(transformation(
                extent={{10,10},{-10,-10}},
                rotation=180,
                origin={0,70})));
          Modelica.Blocks.Sources.Sine P(
            freqHz=1,
            phase=0,
            offset=0,
            amplitude=1000)
            annotation (Placement(transformation(extent={{100,80},{80,100}})));
          Modelica.Blocks.Sources.Sine Frequency1(
            amplitude=5,
            freqHz=1/10,
            offset=60)
            annotation (Placement(transformation(extent={{-100,40},{-80,60}})));
          Modelica.Blocks.Sources.Sine Voltage1(
            phase=0,
            amplitude=10,
            offset=120,
            freqHz=1/5)
            annotation (Placement(transformation(extent={{-100,80},{-80,100}})));
          Modelica.Blocks.Sources.Constant Q(k=0)
            annotation (Placement(transformation(extent={{100,40},{80,60}})));
          Model.uPMUSource_3ph uPMUSource_3ph
            annotation (Placement(transformation(extent={{-38,-10},{-18,10}})));
          Modelica.Blocks.Sources.Sine Frequency2(
            amplitude=5,
            freqHz=1/5,
            offset=30)
            annotation (Placement(transformation(extent={{-100,-30},{-80,-10}})));
          Modelica.Blocks.Sources.Sine Voltage2(
            phase=0,
            offset=120,
            freqHz=1/10,
            amplitude=20)
            annotation (Placement(transformation(extent={{-100,0},{-80,20}})));
          Modelica.Blocks.Sources.Sine Frequency3(
            amplitude=5,
            freqHz=1/10,
            offset=90)
            annotation (Placement(transformation(extent={{-100,-100},{-80,-80}})));
          Modelica.Blocks.Sources.Sine Voltage3(
            phase=0,
            offset=120,
            freqHz=1/2.5,
            amplitude=30)
            annotation (Placement(transformation(extent={{-100,-70},{-80,-50}})));
          Components.Sensor.Model.Probe3ph sens_3ph_wye
            annotation (Placement(transformation(extent={{0,-10},{20,10}})));
          Buildings.Electrical.AC.ThreePhasesUnbalanced.Loads.Resistive load_wye(
            V_nominal=120,
            P_nominal=1200,
            loadConn=Buildings.Electrical.Types.LoadConnection.wye_to_wyeg)
            annotation (Placement(transformation(extent={{40,-10},{60,10}})));
          Buildings.Electrical.AC.ThreePhasesUnbalanced.Loads.Resistive load_delta(
            V_nominal=120,
            P_nominal=1200,
            loadConn=Buildings.Electrical.Types.LoadConnection.wye_to_delta)
            annotation (Placement(transformation(extent={{40,-40},{60,-20}})));
          Components.Sensor.Model.Probe3ph sens_3ph_delta
            annotation (Placement(transformation(extent={{0,-40},{20,-20}})));
        equation
          connect(uPMUSource.terminal, sens_1ph.terminal_n)
            annotation (Line(points={{-40,70},{-25,70},{-10,70}}, color={0,120,120}));
          connect(sens_1ph.terminal_p, uPMUInput.term_p)
            annotation (Line(points={{10,70},{25,70},{40,70}}, color={0,120,120}));
          connect(uPMUInput.P,P. y) annotation (Line(points={{62,74},{72,74},{72,90},{79,
                  90}},          color={0,0,127}));
          connect(Voltage1.y, uPMUSource.V) annotation (Line(points={{-79,90},{-70,90},{
                  -70,74},{-62,74}}, color={0,0,127}));
          connect(uPMUSource.f, Frequency1.y) annotation (Line(points={{-62,66},{-70,66},
                  {-70,50},{-79,50}}, color={0,0,127}));
          connect(Q.y, uPMUInput.Q) annotation (Line(points={{79,50},{70,50},{70,66},{62,
                  66}},     color={0,0,127}));
          connect(uPMUSource_3ph.V1, uPMUSource.V) annotation (Line(points={{-39,9},{-39,
                  8},{-66,8},{-66,74},{-64,74},{-62,74}}, color={0,0,127}));
          connect(uPMUSource_3ph.f1, uPMUSource.f) annotation (Line(points={{-39,7},{-40,
                  7},{-40,6},{-68,6},{-68,66},{-64,66},{-62,66}}, color={0,0,127}));
          connect(Voltage2.y, uPMUSource_3ph.V2) annotation (Line(points={{-79,10},{-74,
                  10},{-74,3},{-39,3}}, color={0,0,127}));
          connect(Frequency2.y, uPMUSource_3ph.f2) annotation (Line(points={{-79,-20},{-74,
                  -20},{-74,1},{-39,1}}, color={0,0,127}));
          connect(uPMUSource_3ph.V3, Voltage3.y) annotation (Line(points={{-39,-3},{-40,
                  -3},{-40,-2},{-64,-2},{-68,-2},{-68,-60},{-79,-60}}, color={0,0,127}));
          connect(uPMUSource_3ph.f3, Frequency3.y) annotation (Line(points={{-39,-5},{-40,
                  -5},{-40,-4},{-66,-4},{-66,-90},{-79,-90}}, color={0,0,127}));
          connect(uPMUSource_3ph.terminal, sens_3ph_wye.terminal_n)
            annotation (Line(points={{-18,0},{0,0}}, color={0,120,120}));
          connect(sens_3ph_wye.terminal_p, load_wye.terminal)
            annotation (Line(points={{20,0},{20,0},{40,0}}, color={0,120,120}));
          connect(load_delta.terminal, sens_3ph_delta.terminal_p)
            annotation (Line(points={{40,-30},{20,-30}}, color={0,120,120}));
          connect(sens_3ph_delta.terminal_n, uPMUSource_3ph.terminal) annotation (Line(
                points={{0,-30},{-10,-30},{-10,0},{-18,0}}, color={0,120,120}));
          annotation (Icon(coordinateSystem(preserveAspectRatio=false)),
          experiment(StopTime=15), Diagram(
                coordinateSystem(preserveAspectRatio=false)));
        end Test_uPMUSource;
      end Examples;
    end uPMU;

    package Conversion
      package Model

        model DCtoAC
          extends Buildings.Electrical.Interfaces.VariableVoltageSource(
            V(start = 1),
            redeclare package PhaseSystem = PhaseSystems.TwoConductor,
            redeclare Buildings.Electrical.DC.Interfaces.Terminal_p terminal,
            final potentialReference=true,
            final definiteReference=false);
          Modelica.Electrical.Analog.Interfaces.NegativePin n "Negative pin"
            annotation (Placement(transformation(extent={{-110,-10},{-90,10}})));
        equation
          terminal.v[1] = V_in_internal;
          terminal.v[2] = n.v;
          sum(terminal.i) + n.i = 0;
          annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},
                    {100,100}}), graphics={
                Line(points={{-40,0},{40,0}},  color={0,0,0},
                  origin={10,0},
                  rotation=90),
                Line(points={{0,26},{0,-54}},     color={0,0,0},
                  origin={36,0},
                  rotation=90),
                Line(points={{0,46},{0,-34}}, color={0,0,0},
                  origin={-44,0},
                  rotation=90),
                Line(points={{-20,0},{20,0}},
                                            color={0,0,0},
                  origin={-10,0},
                  rotation=90),
                Text(
                  extent={{50,70},{150,20}},
                  lineColor={0,0,0},
                  textString="+"),
                Text(
                  extent={{50,-12},{150,-62}},
                  lineColor={0,0,0},
                  textString="-"),
                Text(visible = not use_V_in,
                  extent={{-150,60},{150,100}},
                  lineColor={0,0,0},
                  textString="V=%V")}),    Documentation(info="<html>
<p>
This model represents a simple DC voltage source with variable voltage.
</p>
</html>",         revisions="<html>
<ul>
<li>
October 14, 2014, by Marco Bonvini:<br/>
Added model and documentation.
</li>
</ul>
</html>"));
        end DCtoAC;

        model DCtoAC_2

          Buildings.Electrical.DC.Interfaces.Terminal_p terminal_p
            annotation (Placement(transformation(extent={{90,-10},{110,10}})));
          Modelica.Electrical.Analog.Interfaces.NegativePin n "Negative pin"
            annotation (Placement(transformation(extent={{-90,-50},{-110,-30}})));
          Modelica.Electrical.Analog.Interfaces.PositivePin p "Positive pin"
            annotation (Placement(transformation(extent={{-110,10},{-90,30}})));
        equation
          terminal_p.v[1] = p.v;
          terminal_p.v[2] = n.v;
          terminal_p.i[1] = p.i;
          terminal_p.i[2] = n.i;
          annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
                coordinateSystem(preserveAspectRatio=false)));
        end DCtoAC_2;
      end Model;

      package Exmaples
          extends Modelica.Icons.ExamplesPackage;

      end Exmaples;
    end Conversion;
  end Components;

  package Systems
    model FLEXGRID
      import SmartInverter = SCooDER;

      SmartInverter.Components.Transformer.Model.MPZ mpz_dist
        annotation (Placement(transformation(extent={{80,0},{60,20}})));
      SmartInverter.Components.Sensor.Model.Probe3ph sens_FLEXGRID(V_nominal=208)
        annotation (Placement(transformation(
            extent={{10,-10},{-10,10}},
            rotation=90,
            origin={90,40})));
      Modelica.Blocks.Interfaces.RealInput scale3(start=1,
        min=0,
        max=1,
        unit="1") "Shading of PV module" annotation (Placement(transformation(
            origin={-110,12},
            extent={{10,10},{-10,-10}},
            rotation=180), iconTransformation(
            extent={{-10,-10},{10,10}},
            rotation=0,
            origin={-110,-20})));
      Modelica.Blocks.Interfaces.RealInput scale1(start=1,
        min=0,
        max=1,
        unit="1") "Shading of PV module" annotation (Placement(transformation(
            origin={-110,40},
            extent={{10,10},{-10,-10}},
            rotation=180), iconTransformation(
            extent={{-10,-10},{10,10}},
            rotation=0,
            origin={-110,20})));
      Modelica.Blocks.Interfaces.RealInput scale2(start=1,
        min=0,
        max=1,
        unit="1") "Shading of PV module" annotation (Placement(transformation(
            origin={-110,26},
            extent={{10,10},{-10,-10}},
            rotation=180), iconTransformation(
            extent={{-10,-10},{10,10}},
            rotation=0,
            origin={-110,0})));
      SmartInverter.Components.Battery.Model.Battery battery1
        annotation (Placement(transformation(extent={{-30,30},{-10,50}})));
      SmartInverter.Components.Battery.Model.Battery battery2
        annotation (Placement(transformation(extent={{-30,-10},{-10,10}})));
      SmartInverter.Components.Battery.Model.Battery battery3
        annotation (Placement(transformation(extent={{-30,-50},{-10,-30}})));
      SmartInverter.Components.Photovoltaics.Model.PVModule_simple pv1
        annotation (Placement(transformation(extent={{-64,46},{-44,66}})));
      SmartInverter.Components.Photovoltaics.Model.PVModule_simple pv2(n=28)
        annotation (Placement(transformation(extent={{-64,6},{-44,26}})));
      SmartInverter.Components.Photovoltaics.Model.PVModule_simple pv3
        annotation (Placement(transformation(extent={{-64,-34},{-44,-14}})));
      Buildings.BoundaryConditions.WeatherData.Bus
                      weaBus "Bus with weather data"
        annotation (Placement(transformation(extent={{-110,70},{-90,90}})));
      Buildings.Electrical.AC.ThreePhasesUnbalanced.Lines.TwoPortMatrixRL FL_feed(
        Z12=20*(1.0/5280.0)*{0.0953,0.8515},
        Z13=20*(1.0/5280.0)*{0.0953,0.7266},
        Z23=20*(1.0/5280.0)*{0.0953,0.7802},
        V_nominal=208,
        Z11=20*(1.0/5280.0)*{0.4013,1.4133},
        Z22=20*(1.0/5280.0)*{0.4013,1.4133},
        Z33=20*(1.0/5280.0)*{0.4013,1.4133}) annotation (Placement(transformation(
            extent={{-10,10},{10,-10}},
            rotation=-90,
            origin={90,70})));

      Buildings.Electrical.AC.ThreePhasesUnbalanced.Interfaces.Terminal_p
                 terminal_p "Electric terminal side p"
        annotation (Placement(transformation(extent={{100,80},{120,100}}),
            iconTransformation(extent={{100,80},{120,100}})));
      SmartInverter.Components.Inverter.Model.Inverter inverter1
        annotation (Placement(transformation(extent={{26,40},{6,60}})));
      SmartInverter.Components.Inverter.Model.Inverter inverter2
        annotation (Placement(transformation(extent={{26,0},{6,20}})));
      SmartInverter.Components.Inverter.Model.Inverter inverter3
        annotation (Placement(transformation(extent={{26,-40},{6,-20}})));
      SmartInverter.Components.Inverter.Interfaces.InvCtrlBus
                                                         invCtrlBus1
                                                                    annotation (
          Placement(transformation(extent={{-60,-110},{-40,-90}}),
                                                                 iconTransformation(
              extent={{-60,-110},{-40,-90}})));
      SmartInverter.Components.Inverter.Interfaces.InvCtrlBus
                                                         invCtrlBus2
                                                                    annotation (
          Placement(transformation(extent={{-10,-110},{10,-90}}),iconTransformation(
              extent={{-10,-110},{10,-90}})));
      SmartInverter.Components.Inverter.Interfaces.InvCtrlBus
                                                         invCtrlBus3
                                                                    annotation (
          Placement(transformation(extent={{40,-110},{60,-90}}), iconTransformation(
              extent={{40,-110},{60,-90}})));
    equation
      connect(sens_FLEXGRID.terminal_p,mpz_dist. mpz_head)
        annotation (Line(points={{90,30},{90,10},{80,10}},
                                                   color={0,120,120}));
      connect(inverter1.term_p,mpz_dist. inv_1) annotation (Line(points={{26,50},{
              40,50},{40,16},{60,16}},
                                  color={0,120,120}));
      connect(mpz_dist.inv_2, inverter2.term_p)
        annotation (Line(points={{60,10},{26,10}},     color={0,120,120}));
      connect(mpz_dist.inv_3, inverter3.term_p) annotation (Line(points={{60,4},{40,
              4},{40,-30},{26,-30}}, color={0,120,120}));
      connect(inverter2.P_PV, pv2.P)
        annotation (Line(points={{4,16},{-20,16},{-43,16}},
                                                 color={0,0,127}));
      connect(inverter3.P_PV, pv3.P)
        annotation (Line(points={{4,-24},{-20,-24},{-43,-24}},
                                                     color={0,0,127}));
      connect(inverter1.P_PV, pv1.P)
        annotation (Line(points={{4,56},{-20,56},{-43,56}},
                                                   color={0,0,127}));
      connect(inverter3.P_Batt, battery3.P_batt) annotation (Line(points={{4,-33},{
              -4,-33},{-4,-40},{-9,-40}}, color={0,0,127}));
      connect(inverter2.P_Batt, battery2.P_batt)
        annotation (Line(points={{4,7},{-4,7},{-4,0},{-9,0}}, color={0,0,127}));
      connect(inverter1.P_Batt, battery1.P_batt) annotation (Line(points={{4,47},{
              -4,47},{-4,40},{-9,40}}, color={0,0,127}));
      connect(scale1, pv1.scale)
        annotation (Line(points={{-110,40},{-66,40},{-66,52}}, color={0,0,127}));
      connect(scale2, pv2.scale) annotation (Line(points={{-110,26},{-92,26},{-92,
              12},{-66,12}},
                        color={0,0,127}));
      connect(scale3, pv3.scale) annotation (Line(points={{-110,12},{-94,12},{-94,
              -28},{-66,-28}},
                          color={0,0,127}));
      connect(pv1.weaBus, weaBus) annotation (Line(
          points={{-64,60},{-80,60},{-80,80},{-100,80}},
          color={255,204,51},
          thickness=0.5), Text(
          string="%second",
          index=1,
          extent={{6,3},{6,3}}));
      connect(pv2.weaBus, weaBus) annotation (Line(
          points={{-64,20},{-80,20},{-80,80},{-100,80}},
          color={255,204,51},
          thickness=0.5), Text(
          string="%second",
          index=1,
          extent={{6,3},{6,3}}));
      connect(pv3.weaBus, weaBus) annotation (Line(
          points={{-64,-20},{-80,-20},{-80,80},{-100,80}},
          color={255,204,51},
          thickness=0.5), Text(
          string="%second",
          index=1,
          extent={{6,3},{6,3}}));
      connect(FL_feed.terminal_p, sens_FLEXGRID.terminal_n)
        annotation (Line(points={{90,60},{90,50}}, color={0,120,120}));
      connect(FL_feed.terminal_n, terminal_p) annotation (Line(points={{90,80},{90,
              80},{90,90},{110,90}}, color={0,120,120}));
      connect(inverter3.batt_ctrl_inv, battery3.P_ctrl) annotation (Line(points={{5,
              -38},{0,-38},{0,-54},{-40,-54},{-40,-40},{-32,-40}}, color={0,0,127}));
      connect(inverter2.batt_ctrl_inv, battery2.P_ctrl) annotation (Line(points={{5,
              2},{0,2},{0,-14},{-40,-14},{-40,0},{-32,0}}, color={0,0,127}));
      connect(inverter1.batt_ctrl_inv, battery1.P_ctrl) annotation (Line(points={{5,
              42},{0,42},{0,26},{-40,26},{-40,40},{-32,40}}, color={0,0,127}));
      connect(invCtrlBus3, inverter3.invCtrlBus) annotation (Line(
          points={{50,-100},{50,-100},{50,-54},{16,-54},{16,-40}},
          color={255,204,51},
          thickness=0.5), Text(
          string="%first",
          index=-1,
          extent={{-6,3},{-6,3}}));
      connect(inverter2.invCtrlBus, invCtrlBus2) annotation (Line(
          points={{16,0},{16,0},{16,-14},{34,-14},{34,-86},{0,-86},{0,-100}},
          color={255,204,51},
          thickness=0.5), Text(
          string="%second",
          index=1,
          extent={{6,3},{6,3}}));
      connect(inverter1.invCtrlBus, invCtrlBus1) annotation (Line(
          points={{16,40},{16,40},{16,26},{32,26},{32,-84},{-50,-84},{-50,-100}},
          color={255,204,51},
          thickness=0.5), Text(
          string="%second",
          index=1,
          extent={{6,3},{6,3}}));
      annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
            coordinateSystem(preserveAspectRatio=false)));
    end FLEXGRID;

    model FLEXGRID_FMU

      FLEXGRID flexgrid
        annotation (Placement(transformation(extent={{-20,20},{20,60}})));
      Buildings.BoundaryConditions.WeatherData.ReaderTMY3 weaDatInpCon1(
        computeWetBulbTemperature=false, filNam="C:/Users/Christoph/Documents/SmartInverter/smartinverter_simulation/ExampleData/USA_CA_San.Francisco.Intl.AP.724940_TMY3_CONVERTED.mos")
        "Weather data reader with radiation data obtained from the inputs' connectors"
        annotation (Placement(transformation(extent={{-80,70},{-60,90}})));
      Modelica.Blocks.Interfaces.RealInput scale3(start=1,
        min=0,
        max=1,
        unit="1") "Shading of PV module" annotation (Placement(transformation(
            origin={-110,12},
            extent={{10,10},{-10,-10}},
            rotation=180), iconTransformation(
            extent={{-10,-10},{10,10}},
            rotation=0,
            origin={-110,-20})));
      Modelica.Blocks.Interfaces.RealInput scale1(start=1,
        min=0,
        max=1,
        unit="1") "Shading of PV module" annotation (Placement(transformation(
            origin={-110,40},
            extent={{10,10},{-10,-10}},
            rotation=180), iconTransformation(
            extent={{-10,-10},{10,10}},
            rotation=0,
            origin={-110,20})));
      Modelica.Blocks.Interfaces.RealInput scale2(start=1,
        min=0,
        max=1,
        unit="1") "Shading of PV module" annotation (Placement(transformation(
            origin={-110,26},
            extent={{10,10},{-10,-10}},
            rotation=180), iconTransformation(
            extent={{-10,-10},{10,10}},
            rotation=0,
            origin={-110,0})));
      Modelica.Blocks.Interfaces.RealInput batt_ctrl3(start=0, unit="W")
        "Battery Power" annotation (Placement(transformation(
            origin={-110,-88},
            extent={{10,10},{-10,-10}},
            rotation=180), iconTransformation(
            extent={{-10,-10},{10,10}},
            rotation=0,
            origin={-110,-88})));
      Modelica.Blocks.Interfaces.RealInput batt_ctrl1(start=0, unit="W")
        "Battery Power" annotation (Placement(transformation(
            origin={-110,-60},
            extent={{10,10},{-10,-10}},
            rotation=180), iconTransformation(
            extent={{-10,-10},{10,10}},
            rotation=0,
            origin={-110,-50})));
      Modelica.Blocks.Interfaces.RealInput batt_ctrl2(start=0, unit="W")
        "Battery Power" annotation (Placement(transformation(
            origin={-110,-74},
            extent={{10,10},{-10,-10}},
            rotation=180), iconTransformation(
            extent={{-10,-10},{10,10}},
            rotation=0,
            origin={-110,-70})));
      Modelica.Blocks.Interfaces.RealInput q_ctrl1(start=0, unit="var") "Reactive power control of inverter." annotation (Placement(transformation(
            origin={12,-110},
            extent={{10,10},{-10,-10}},
            rotation=270), iconTransformation(
            extent={{-10,-10},{10,10}},
            rotation=90,
            origin={-30,-110})));
      Modelica.Blocks.Interfaces.RealInput q_ctrl2(start=0, unit="var") "Reactive power control of inverter." annotation (Placement(transformation(
            origin={26,-110},
            extent={{10,10},{-10,-10}},
            rotation=270), iconTransformation(
            extent={{-10,-10},{10,10}},
            rotation=90,
            origin={-10,-110})));
      Modelica.Blocks.Interfaces.RealInput q_ctrl3(start=0, unit="var") "Reactive power control of inverter." annotation (Placement(
            transformation(
            origin={40,-110},
            extent={{10,10},{-10,-10}},
            rotation=270), iconTransformation(
            extent={{-10,-10},{10,10}},
            rotation=90,
            origin={10,-110})));
      Modelica.Blocks.Interfaces.RealInput plim3(
        start=1,
        min=0,
        max=1,
        unit="1") "Power Limit of Inverter" annotation (Placement(transformation(
            origin={94,-110},
            extent={{10,10},{-10,-10}},
            rotation=270), iconTransformation(
            extent={{-10,-10},{10,10}},
            rotation=90,
            origin={90,-110})));
      Modelica.Blocks.Interfaces.RealInput plim2(
        start=1,
        min=0,
        max=1,
        unit="1") "Power Limit of Inverter" annotation (Placement(transformation(
            origin={80,-110},
            extent={{10,10},{-10,-10}},
            rotation=270), iconTransformation(
            extent={{-10,-10},{10,10}},
            rotation=90,
            origin={70,-110})));
      Modelica.Blocks.Interfaces.RealInput plim1(
        start=1,
        min=0,
        max=1,
        unit="1") "Power Limit of Inverter" annotation (Placement(transformation(
            origin={66,-110},
            extent={{10,10},{-10,-10}},
            rotation=270), iconTransformation(
            extent={{-10,-10},{10,10}},
            rotation=90,
            origin={50,-110})));
      Interfaces.FLEXGRID_interface interface
        annotation (Placement(transformation(extent={{-20,-30},{20,10}})));
      Components.uPMU.Model.uPMUSource_3ph source
        annotation (Placement(transformation(extent={{60,48},{40,68}})));
      Modelica.Blocks.Interfaces.RealInput V1(unit="V", start=120) "RMS voltage of the source" annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=180,
            origin={110,80}),  iconTransformation(
            extent={{-10,-10},{10,10}},
            rotation=180,
            origin={110,90})));
      Modelica.Blocks.Interfaces.RealInput f1(unit="Hz", start=60) "Frequency of the source" annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=180,
            origin={110,66}),  iconTransformation(
            extent={{-10,-10},{10,10}},
            rotation=180,
            origin={110,70})));
      Modelica.Blocks.Interfaces.RealInput V2(unit="V", start=120) "RMS voltage of the source" annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=180,
            origin={110,50}),  iconTransformation(
            extent={{-10,-10},{10,10}},
            rotation=180,
            origin={110,50})));
      Modelica.Blocks.Interfaces.RealInput f2(unit="Hz", start=60) "Frequency of the source" annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=180,
            origin={110,30}),  iconTransformation(
            extent={{-10,-10},{10,10}},
            rotation=180,
            origin={110,30})));
      Modelica.Blocks.Interfaces.RealInput V3(unit="V", start=120) "RMS voltage of the source" annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=180,
            origin={110,0}),   iconTransformation(
            extent={{-10,-10},{10,10}},
            rotation=180,
            origin={110,10})));
      Modelica.Blocks.Interfaces.RealInput f3(unit="Hz", start=60) "Frequency of the source" annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=180,
            origin={110,-10}), iconTransformation(
            extent={{-10,-10},{10,10}},
            rotation=180,
            origin={110,-10})));
    equation
      connect(weaDatInpCon1.weaBus, flexgrid.weaBus) annotation (Line(
          points={{-60,80},{-30,80},{-30,56},{-20,56}},
          color={255,204,51},
          thickness=0.5));
      connect(flexgrid.invCtrlBus1, interface.invCtrlBus1) annotation (Line(
          points={{-10,20},{-10,10}},
          color={255,204,51},
          thickness=0.5));
      connect(flexgrid.invCtrlBus2, interface.invCtrlBus2) annotation (Line(
          points={{0,20},{0,10}},
          color={255,204,51},
          thickness=0.5));
      connect(flexgrid.invCtrlBus3, interface.invCtrlBus3) annotation (Line(
          points={{10,20},{10,10}},
          color={255,204,51},
          thickness=0.5));
      connect(interface.batt_ctrl2, batt_ctrl2) annotation (Line(points={{-22,-24},
              {-80,-24},{-80,-74},{-110,-74}}, color={0,0,127}));
      connect(interface.batt_ctrl3, batt_ctrl3) annotation (Line(points={{-22,-28},
              {-76,-28},{-76,-88},{-110,-88}}, color={0,0,127}));
      connect(plim1, interface.plim1) annotation (Line(points={{66,-110},{66,-86},{
              10,-86},{10,-32}}, color={0,0,127}));
      connect(plim2, interface.plim2) annotation (Line(points={{80,-110},{80,-84},{
              14,-84},{14,-32}}, color={0,0,127}));
      connect(plim3, interface.plim3) annotation (Line(points={{94,-110},{94,-110},
              {94,-82},{18,-82},{18,-32}}, color={0,0,127}));
      connect(scale1, flexgrid.scale1) annotation (Line(points={{-110,40},{-84,40},
              {-84,44},{-22,44}}, color={0,0,127}));
      connect(scale2, flexgrid.scale2) annotation (Line(points={{-110,26},{-80,26},
              {-80,40},{-22,40}}, color={0,0,127}));
      connect(scale3, flexgrid.scale3) annotation (Line(points={{-110,12},{-76,12},
              {-76,36},{-22,36}}, color={0,0,127}));
      connect(batt_ctrl1, interface.batt_ctrl1) annotation (Line(points={{-110,-60},
              {-84,-60},{-84,-20},{-22,-20}}, color={0,0,127}));
      connect(flexgrid.terminal_p, source.terminal)
        annotation (Line(points={{22,58},{31,58},{40,58}}, color={0,120,120}));
      connect(V1, source.V1) annotation (Line(points={{110,80},{80,80},{80,67},{61,
              67}}, color={0,0,127}));
      connect(f1, source.f1)
        annotation (Line(points={{110,66},{61,66},{61,65}}, color={0,0,127}));
      connect(V2, source.V2) annotation (Line(points={{110,50},{86,50},{86,61},{61,
              61}}, color={0,0,127}));
      connect(f2, source.f2) annotation (Line(points={{110,30},{84,30},{84,59},{61,
              59}}, color={0,0,127}));
      connect(V3, source.V3) annotation (Line(points={{110,0},{82,0},{82,55},{61,55}},
            color={0,0,127}));
      connect(f3, source.f3) annotation (Line(points={{110,-10},{80,-10},{80,53},{
              61,53}}, color={0,0,127}));
      connect(interface.q_ctrl1, q_ctrl1) annotation (Line(points={{-6,-32},{-6,-32},
              {-6,-94},{12,-94},{12,-110}},           color={0,0,127}));
      connect(interface.q_ctrl2, q_ctrl2) annotation (Line(points={{-2,-32},{-2,-32},
              {-2,-92},{26,-92},{26,-110}},           color={0,0,127}));
      connect(interface.q_ctrl3, q_ctrl3) annotation (Line(points={{2,-32},{2,-32},
              {2,-34},{2,-90},{40,-90},{40,-110}},                   color={0,0,127}));
      annotation (Icon(coordinateSystem(preserveAspectRatio=false)),
      experiment(StartTime=2.09952e+07, StopTime=2.22039e+07),
      Diagram(coordinateSystem(preserveAspectRatio=false)));
    end FLEXGRID_FMU;

    model FLEXGRID_voltvar_FMU
      parameter Real V_nominal(min=0, unit="V") = 240 "Nominal sytem voltage to scale Vp.u.";
      parameter Real v_max( start=1.05, unit="1")=1.05 "Voltage maximum [p.u.]";
      parameter Real v_maxdead( start=1.01, unit="1")=1.01 "Upper bound of deadband [p.u.]";
      parameter Real v_mindead( start=0.99, unit="1")=0.99 "Upper bound of deadband [p.u.]";
      parameter Real v_min( start=0.95, unit="1")=0.95 "Voltage minimum [p.u.]";
      parameter Real q_maxind( start=1000, unit="var")=2500 "Maximal Reactive Power (Inductive) [var]";
      parameter Real q_maxcap( start=1000, unit="var")=2500 "Maximal Reactive Power (Capacitive) [var]";

      FLEXGRID flexgrid
        annotation (Placement(transformation(extent={{-20,20},{20,60}})));
      Buildings.BoundaryConditions.WeatherData.ReaderTMY3 weaDatInpCon1(
        computeWetBulbTemperature=false, filNam="C:/Users/Christoph/Documents/SmartInverter/smartinverter_simulation/ExampleData/USA_CA_San.Francisco.Intl.AP.724940_TMY3_CONVERTED.mos")
        "Weather data reader with radiation data obtained from the inputs' connectors"
        annotation (Placement(transformation(extent={{-80,70},{-60,90}})));
      Modelica.Blocks.Interfaces.RealInput scale3(start=1,
        min=0,
        max=1,
        unit="1") "Shading of PV module" annotation (Placement(transformation(
            origin={-110,12},
            extent={{10,10},{-10,-10}},
            rotation=180), iconTransformation(
            extent={{-10,-10},{10,10}},
            rotation=0,
            origin={-110,-20})));
      Modelica.Blocks.Interfaces.RealInput scale1(start=1,
        min=0,
        max=1,
        unit="1") "Shading of PV module" annotation (Placement(transformation(
            origin={-110,40},
            extent={{10,10},{-10,-10}},
            rotation=180), iconTransformation(
            extent={{-10,-10},{10,10}},
            rotation=0,
            origin={-110,20})));
      Modelica.Blocks.Interfaces.RealInput scale2(start=1,
        min=0,
        max=1,
        unit="1") "Shading of PV module" annotation (Placement(transformation(
            origin={-110,26},
            extent={{10,10},{-10,-10}},
            rotation=180), iconTransformation(
            extent={{-10,-10},{10,10}},
            rotation=0,
            origin={-110,0})));
      Modelica.Blocks.Interfaces.RealInput batt_ctrl3(start=0, unit="W")
        "Battery Power" annotation (Placement(transformation(
            origin={-110,-88},
            extent={{10,10},{-10,-10}},
            rotation=180), iconTransformation(
            extent={{-10,-10},{10,10}},
            rotation=0,
            origin={-110,-88})));
      Modelica.Blocks.Interfaces.RealInput batt_ctrl1(start=0, unit="W")
        "Battery Power" annotation (Placement(transformation(
            origin={-110,-60},
            extent={{10,10},{-10,-10}},
            rotation=180), iconTransformation(
            extent={{-10,-10},{10,10}},
            rotation=0,
            origin={-110,-50})));
      Modelica.Blocks.Interfaces.RealInput batt_ctrl2(start=0, unit="W")
        "Battery Power" annotation (Placement(transformation(
            origin={-110,-74},
            extent={{10,10},{-10,-10}},
            rotation=180), iconTransformation(
            extent={{-10,-10},{10,10}},
            rotation=0,
            origin={-110,-70})));
      Modelica.Blocks.Interfaces.RealInput plim3(
        start=1,
        min=0,
        max=1,
        unit="1") "Power Limit of Inverter" annotation (Placement(transformation(
            origin={94,-110},
            extent={{10,10},{-10,-10}},
            rotation=270), iconTransformation(
            extent={{-10,-10},{10,10}},
            rotation=90,
            origin={90,-110})));
      Modelica.Blocks.Interfaces.RealInput plim2(
        start=1,
        min=0,
        max=1,
        unit="1") "Power Limit of Inverter" annotation (Placement(transformation(
            origin={80,-110},
            extent={{10,10},{-10,-10}},
            rotation=270), iconTransformation(
            extent={{-10,-10},{10,10}},
            rotation=90,
            origin={70,-110})));
      Modelica.Blocks.Interfaces.RealInput plim1(
        start=1,
        min=0,
        max=1,
        unit="1") "Power Limit of Inverter" annotation (Placement(transformation(
            origin={66,-110},
            extent={{10,10},{-10,-10}},
            rotation=270), iconTransformation(
            extent={{-10,-10},{10,10}},
            rotation=90,
            origin={50,-110})));
      Interfaces.FLEXGRID_interface_voltvar interface(
        V_nominal=V_nominal,
        v_max=v_max,
        v_maxdead=v_maxdead,
        v_mindead=v_mindead,
        v_min=v_min,
        q_maxind=q_maxind,
        q_maxcap=q_maxcap)
        annotation (Placement(transformation(extent={{-20,-30},{20,10}})));
      Components.uPMU.Model.uPMUSource_3ph source
        annotation (Placement(transformation(extent={{60,48},{40,68}})));
      Modelica.Blocks.Interfaces.RealInput V1(unit="V", start=120) "RMS voltage of the source" annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=180,
            origin={110,80}),  iconTransformation(
            extent={{-10,-10},{10,10}},
            rotation=180,
            origin={110,90})));
      Modelica.Blocks.Interfaces.RealInput f1(unit="Hz", start=60) "Frequency of the source" annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=180,
            origin={110,66}),  iconTransformation(
            extent={{-10,-10},{10,10}},
            rotation=180,
            origin={110,70})));
      Modelica.Blocks.Interfaces.RealInput V2(unit="V", start=120) "RMS voltage of the source" annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=180,
            origin={110,50}),  iconTransformation(
            extent={{-10,-10},{10,10}},
            rotation=180,
            origin={110,50})));
      Modelica.Blocks.Interfaces.RealInput f2(unit="Hz", start=60) "Frequency of the source" annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=180,
            origin={110,30}),  iconTransformation(
            extent={{-10,-10},{10,10}},
            rotation=180,
            origin={110,30})));
      Modelica.Blocks.Interfaces.RealInput V3(unit="V", start=120) "RMS voltage of the source" annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=180,
            origin={110,0}),   iconTransformation(
            extent={{-10,-10},{10,10}},
            rotation=180,
            origin={110,10})));
      Modelica.Blocks.Interfaces.RealInput f3(unit="Hz", start=60) "Frequency of the source" annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=180,
            origin={110,-10}), iconTransformation(
            extent={{-10,-10},{10,10}},
            rotation=180,
            origin={110,-10})));
    equation
      connect(weaDatInpCon1.weaBus, flexgrid.weaBus) annotation (Line(
          points={{-60,80},{-30,80},{-30,56},{-20,56}},
          color={255,204,51},
          thickness=0.5));
      connect(interface.batt_ctrl2, batt_ctrl2) annotation (Line(points={{-22,-24},{
              -80,-24},{-80,-74},{-110,-74}}, color={0,0,127}));
      connect(interface.batt_ctrl3, batt_ctrl3) annotation (Line(points={{-22,-28},{
              -76,-28},{-76,-88},{-110,-88}}, color={0,0,127}));
      connect(plim1, interface.plim1) annotation (Line(points={{66,-110},{66,-86},{10,
              -86},{10,-32}}, color={0,0,127}));
      connect(plim2, interface.plim2) annotation (Line(points={{80,-110},{80,-84},{14,
              -84},{14,-32}}, color={0,0,127}));
      connect(plim3, interface.plim3) annotation (Line(points={{94,-110},{94,-110},{
              94,-82},{18,-82},{18,-32}}, color={0,0,127}));
      connect(scale1, flexgrid.scale1) annotation (Line(points={{-110,40},{-84,40},{
              -84,44},{-22,44}}, color={0,0,127}));
      connect(scale2, flexgrid.scale2) annotation (Line(points={{-110,26},{-80,26},{
              -80,40},{-22,40}}, color={0,0,127}));
      connect(scale3, flexgrid.scale3) annotation (Line(points={{-110,12},{-76,12},{
              -76,36},{-22,36}}, color={0,0,127}));
      connect(batt_ctrl1, interface.batt_ctrl1) annotation (Line(points={{-110,-60},
              {-84,-60},{-84,-20},{-22,-20}}, color={0,0,127}));
      connect(flexgrid.terminal_p, source.terminal)
        annotation (Line(points={{22,58},{31,58},{40,58}}, color={0,120,120}));
      connect(V1, source.V1) annotation (Line(points={{110,80},{80,80},{80,67},{61,67}},
            color={0,0,127}));
      connect(f1, source.f1)
        annotation (Line(points={{110,66},{61,66},{61,65}}, color={0,0,127}));
      connect(V2, source.V2) annotation (Line(points={{110,50},{86,50},{86,61},{61,61}},
            color={0,0,127}));
      connect(f2, source.f2) annotation (Line(points={{110,30},{84,30},{84,59},{61,59}},
            color={0,0,127}));
      connect(V3, source.V3) annotation (Line(points={{110,0},{82,0},{82,55},{61,55}},
            color={0,0,127}));
      connect(f3, source.f3) annotation (Line(points={{110,-10},{80,-10},{80,53},{61,
              53}}, color={0,0,127}));
      connect(flexgrid.invCtrlBus1, interface.invCtrlBus1) annotation (Line(
          points={{-10,20},{-10,15},{-10,10}},
          color={255,204,51},
          thickness=0.5));
      connect(flexgrid.invCtrlBus2, interface.invCtrlBus2) annotation (Line(
          points={{0,20},{0,15},{0,10}},
          color={255,204,51},
          thickness=0.5));
      connect(flexgrid.invCtrlBus3, interface.invCtrlBus3) annotation (Line(
          points={{10,20},{10,15},{10,10}},
          color={255,204,51},
          thickness=0.5));
      annotation (Icon(coordinateSystem(preserveAspectRatio=false)),
      experiment(StartTime=2.09952e+07, StopTime=2.22039e+07),
      Diagram(coordinateSystem(preserveAspectRatio=false)));
    end FLEXGRID_voltvar_FMU;

    model FLEXGRID_old
      import SmartInverter = SCooDER;

      SmartInverter.Components.Transformer.Model.MPZ mpz_dist
        annotation (Placement(transformation(extent={{80,0},{60,20}})));
      SmartInverter.Components.Sensor.Model.Probe3ph sens_FLEXGRID(V_nominal=208)
        annotation (Placement(transformation(
            extent={{10,-10},{-10,10}},
            rotation=90,
            origin={90,40})));
      Modelica.Blocks.Interfaces.RealInput scale3(start=1,
        min=0,
        max=1,
        unit="1") "Shading of PV module" annotation (Placement(transformation(
            origin={-110,12},
            extent={{10,10},{-10,-10}},
            rotation=180), iconTransformation(
            extent={{-10,-10},{10,10}},
            rotation=0,
            origin={-110,-20})));
      Modelica.Blocks.Interfaces.RealInput scale1(start=1,
        min=0,
        max=1,
        unit="1") "Shading of PV module" annotation (Placement(transformation(
            origin={-110,40},
            extent={{10,10},{-10,-10}},
            rotation=180), iconTransformation(
            extent={{-10,-10},{10,10}},
            rotation=0,
            origin={-110,20})));
      Modelica.Blocks.Interfaces.RealInput scale2(start=1,
        min=0,
        max=1,
        unit="1") "Shading of PV module" annotation (Placement(transformation(
            origin={-110,26},
            extent={{10,10},{-10,-10}},
            rotation=180), iconTransformation(
            extent={{-10,-10},{10,10}},
            rotation=0,
            origin={-110,0})));
      SmartInverter.Components.Battery.Model.Battery battery1
        annotation (Placement(transformation(extent={{-30,30},{-10,50}})));
      SmartInverter.Components.Battery.Model.Battery battery2
        annotation (Placement(transformation(extent={{-30,-10},{-10,10}})));
      SmartInverter.Components.Battery.Model.Battery battery3
        annotation (Placement(transformation(extent={{-30,-50},{-10,-30}})));
      SmartInverter.Components.Photovoltaics.Model.PVModule_simple pv1
        annotation (Placement(transformation(extent={{-64,46},{-44,66}})));
      SmartInverter.Components.Photovoltaics.Model.PVModule_simple pv2(n=28)
        annotation (Placement(transformation(extent={{-64,6},{-44,26}})));
      SmartInverter.Components.Photovoltaics.Model.PVModule_simple pv3
        annotation (Placement(transformation(extent={{-64,-34},{-44,-14}})));
      Buildings.BoundaryConditions.WeatherData.Bus
                      weaBus "Bus with weather data"
        annotation (Placement(transformation(extent={{-110,70},{-90,90}})));
      Buildings.Electrical.AC.ThreePhasesUnbalanced.Lines.TwoPortMatrixRL FL_feed(
        Z12=20*(1.0/5280.0)*{0.0953,0.8515},
        Z13=20*(1.0/5280.0)*{0.0953,0.7266},
        Z23=20*(1.0/5280.0)*{0.0953,0.7802},
        V_nominal=208,
        Z11=20*(1.0/5280.0)*{0.4013,1.4133},
        Z22=20*(1.0/5280.0)*{0.4013,1.4133},
        Z33=20*(1.0/5280.0)*{0.4013,1.4133}) annotation (Placement(transformation(
            extent={{-10,10},{10,-10}},
            rotation=-90,
            origin={90,70})));

      Buildings.Electrical.AC.ThreePhasesUnbalanced.Interfaces.Terminal_p
                 terminal_p "Electric terminal side p"
        annotation (Placement(transformation(extent={{100,80},{120,100}}),
            iconTransformation(extent={{100,80},{120,100}})));
      SmartInverter.Systems.Interfaces.FLEXGRID_interface fLEXGRID_interface
        annotation (Placement(transformation(extent={{30,-80},{50,-60}})));
      Modelica.Blocks.Interfaces.RealInput batt_ctrl3(start=0, unit="W")
        "Battery Power" annotation (Placement(transformation(
            origin={-26,-110},
            extent={{10,10},{-10,-10}},
            rotation=270), iconTransformation(
            extent={{-10,-10},{10,10}},
            rotation=0,
            origin={-110,-90})));
      Modelica.Blocks.Interfaces.RealInput batt_ctrl1(start=0, unit="W")
        "Battery Power" annotation (Placement(transformation(
            origin={-54,-110},
            extent={{10,10},{-10,-10}},
            rotation=270), iconTransformation(
            extent={{-10,-10},{10,10}},
            rotation=0,
            origin={-110,-50})));
      Modelica.Blocks.Interfaces.RealInput batt_ctrl2(start=0, unit="W")
        "Battery Power" annotation (Placement(transformation(
            origin={-40,-110},
            extent={{10,10},{-10,-10}},
            rotation=270), iconTransformation(
            extent={{-10,-10},{10,10}},
            rotation=0,
            origin={-110,-70})));
      Modelica.Blocks.Interfaces.RealInput pf2(start=1,
        min=0,
        max=1,
        unit="1") "Power Factor of Inverter" annotation (Placement(transformation(
            origin={20,-110},
            extent={{10,10},{-10,-10}},
            rotation=270), iconTransformation(
            extent={{-10,-10},{10,10}},
            rotation=90,
            origin={-10,-110})));
      Modelica.Blocks.Interfaces.RealInput pf3(
        start=1,
        min=0,
        max=1,
        unit="1") "Power Factor of Inverter" annotation (Placement(transformation(
            origin={34,-110},
            extent={{10,10},{-10,-10}},
            rotation=270), iconTransformation(
            extent={{-10,-10},{10,10}},
            rotation=90,
            origin={10,-110})));
      Modelica.Blocks.Interfaces.RealInput pf1(start=1,
        min=0,
        max=1,
        unit="1") "Power Factor of Inverter" annotation (Placement(transformation(
            origin={6,-110},
            extent={{10,10},{-10,-10}},
            rotation=270), iconTransformation(
            extent={{-10,-10},{10,10}},
            rotation=90,
            origin={-30,-110})));
      Modelica.Blocks.Interfaces.RealInput plim3(
        start=1,
        min=0,
        max=1,
        unit="1") "Power Limit of Inverter" annotation (Placement(transformation(
            origin={90,-110},
            extent={{10,10},{-10,-10}},
            rotation=270), iconTransformation(
            extent={{-10,-10},{10,10}},
            rotation=90,
            origin={90,-110})));
      Modelica.Blocks.Interfaces.RealInput plim2(
        start=1,
        min=0,
        max=1,
        unit="1") "Power Limit of Inverter" annotation (Placement(transformation(
            origin={76,-110},
            extent={{10,10},{-10,-10}},
            rotation=270), iconTransformation(
            extent={{-10,-10},{10,10}},
            rotation=90,
            origin={70,-110})));
      Modelica.Blocks.Interfaces.RealInput plim1(
        start=1,
        min=0,
        max=1,
        unit="1") "Power Limit of Inverter" annotation (Placement(transformation(
            origin={50,-110},
            extent={{10,10},{-10,-10}},
            rotation=270), iconTransformation(
            extent={{-10,-10},{10,10}},
            rotation=90,
            origin={50,-110})));
      SmartInverter.Components.Inverter.Model.Inverter inverter1
        annotation (Placement(transformation(extent={{26,40},{6,60}})));
      SmartInverter.Components.Inverter.Model.Inverter inverter2
        annotation (Placement(transformation(extent={{26,0},{6,20}})));
      SmartInverter.Components.Inverter.Model.Inverter inverter3
        annotation (Placement(transformation(extent={{26,-40},{6,-20}})));
    equation
      connect(sens_FLEXGRID.terminal_p,mpz_dist. mpz_head)
        annotation (Line(points={{90,30},{90,10},{80,10}},
                                                   color={0,120,120}));
      connect(inverter1.term_p,mpz_dist. inv_1) annotation (Line(points={{26,50},{
              40,50},{40,16},{60,16}},
                                  color={0,120,120}));
      connect(mpz_dist.inv_2, inverter2.term_p)
        annotation (Line(points={{60,10},{26,10}},     color={0,120,120}));
      connect(mpz_dist.inv_3, inverter3.term_p) annotation (Line(points={{60,4},{40,
              4},{40,-30},{26,-30}}, color={0,120,120}));
      connect(inverter2.P_PV, pv2.P)
        annotation (Line(points={{4,16},{-20,16},{-43,16}},
                                                 color={0,0,127}));
      connect(inverter3.P_PV, pv3.P)
        annotation (Line(points={{4,-24},{-20,-24},{-43,-24}},
                                                     color={0,0,127}));
      connect(inverter1.P_PV, pv1.P)
        annotation (Line(points={{4,56},{-20,56},{-43,56}},
                                                   color={0,0,127}));
      connect(inverter3.P_Batt, battery3.P_batt) annotation (Line(points={{4,-33},{
              -4,-33},{-4,-40},{-9,-40}}, color={0,0,127}));
      connect(inverter2.P_Batt, battery2.P_batt)
        annotation (Line(points={{4,7},{-4,7},{-4,0},{-9,0}}, color={0,0,127}));
      connect(inverter1.P_Batt, battery1.P_batt) annotation (Line(points={{4,47},{
              -4,47},{-4,40},{-9,40}}, color={0,0,127}));
      connect(scale1, pv1.scale)
        annotation (Line(points={{-110,40},{-66,40},{-66,52}}, color={0,0,127}));
      connect(scale2, pv2.scale) annotation (Line(points={{-110,26},{-92,26},{-92,
              12},{-66,12}},
                        color={0,0,127}));
      connect(scale3, pv3.scale) annotation (Line(points={{-110,12},{-94,12},{-94,
              -28},{-66,-28}},
                          color={0,0,127}));
      connect(pv1.weaBus, weaBus) annotation (Line(
          points={{-64,60},{-80,60},{-80,80},{-100,80}},
          color={255,204,51},
          thickness=0.5), Text(
          string="%second",
          index=1,
          extent={{6,3},{6,3}}));
      connect(pv2.weaBus, weaBus) annotation (Line(
          points={{-64,20},{-80,20},{-80,80},{-100,80}},
          color={255,204,51},
          thickness=0.5), Text(
          string="%second",
          index=1,
          extent={{6,3},{6,3}}));
      connect(pv3.weaBus, weaBus) annotation (Line(
          points={{-64,-20},{-80,-20},{-80,80},{-100,80}},
          color={255,204,51},
          thickness=0.5), Text(
          string="%second",
          index=1,
          extent={{6,3},{6,3}}));
      connect(FL_feed.terminal_p, sens_FLEXGRID.terminal_n)
        annotation (Line(points={{90,60},{90,50}}, color={0,120,120}));
      connect(FL_feed.terminal_n, terminal_p) annotation (Line(points={{90,80},{90,
              80},{90,90},{110,90}}, color={0,120,120}));
      connect(inverter3.batt_ctrl_inv, battery3.P_ctrl) annotation (Line(points={{5,
              -38},{0,-38},{0,-54},{-40,-54},{-40,-40},{-32,-40}}, color={0,0,127}));
      connect(inverter2.batt_ctrl_inv, battery2.P_ctrl) annotation (Line(points={{5,
              2},{0,2},{0,-14},{-40,-14},{-40,0},{-32,0}}, color={0,0,127}));
      connect(inverter1.batt_ctrl_inv, battery1.P_ctrl) annotation (Line(points={{5,
              42},{0,42},{0,26},{-40,26},{-40,40},{-32,40}}, color={0,0,127}));
      connect(inverter1.invCtrlBus, fLEXGRID_interface.invCtrlBus1) annotation (
          Line(
          points={{16,40},{14,40},{14,28},{32,28},{32,-60},{35,-60}},
          color={255,204,51},
          thickness=0.5));
      connect(fLEXGRID_interface.invCtrlBus2, inverter2.invCtrlBus) annotation (
          Line(
          points={{40,-60},{40,-60},{40,-48},{34,-48},{34,-10},{16,-10},{16,0}},
          color={255,204,51},
          thickness=0.5));
      connect(fLEXGRID_interface.invCtrlBus3, inverter3.invCtrlBus) annotation (
          Line(
          points={{45,-60},{46,-60},{46,-54},{16,-54},{16,-40}},
          color={255,204,51},
          thickness=0.5));
      connect(fLEXGRID_interface.batt_ctrl1, batt_ctrl1) annotation (Line(points={{29,-75},
              {-54,-75},{-54,-108},{-54,-110}},                               color=
             {0,0,127}));
      connect(fLEXGRID_interface.batt_ctrl2, batt_ctrl2) annotation (Line(points={{29,-77},
              {-40,-77},{-40,-110}},                    color={0,0,127}));
      connect(fLEXGRID_interface.batt_ctrl3, batt_ctrl3) annotation (Line(points={{29,-79},
              {2,-79},{2,-80},{-26,-80},{-26,-110}},                    color={0,0,
              127}));
      connect(fLEXGRID_interface.pf1, pf1) annotation (Line(points={{37,-81},{36,
              -81},{36,-88},{22,-88},{6,-88},{6,-110}}, color={0,0,127}));
      connect(fLEXGRID_interface.pf2, pf2) annotation (Line(points={{39,-81},{39,
              -91.5},{20,-91.5},{20,-110}}, color={0,0,127}));
      connect(fLEXGRID_interface.pf3, pf3) annotation (Line(points={{41,-81},{41,
              -94.5},{34,-94.5},{34,-110}}, color={0,0,127}));
      connect(plim1, fLEXGRID_interface.plim1) annotation (Line(points={{50,-110},{
              50,-96},{45,-96},{45,-81}}, color={0,0,127}));
      connect(plim2, fLEXGRID_interface.plim2) annotation (Line(points={{76,-110},{
              76,-110},{76,-94},{48,-94},{48,-81},{50,-81},{47,-81}}, color={0,0,
              127}));
      connect(plim3, fLEXGRID_interface.plim3) annotation (Line(points={{90,-110},{
              90,-110},{90,-81},{49,-81}}, color={0,0,127}));
      annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
            coordinateSystem(preserveAspectRatio=false)));
    end FLEXGRID_old;

    package Examples
      extends Modelica.Icons.ExamplesPackage;
      model Test_FLEXGRID

        FLEXGRID flexgrid
          annotation (Placement(transformation(extent={{-20,-20},{20,20}})));
        Modelica.Blocks.Sources.Constant Zero(k=0)
          annotation (Placement(transformation(extent={{-80,-80},{-60,-60}})));
        Modelica.Blocks.Sources.Constant One(k=1)
          annotation (Placement(transformation(extent={{10,-10},{-10,10}},
              rotation=0,
              origin={50,-90})));
        Modelica.Blocks.Sources.Constant Temperature(k=22)
          annotation (Placement(transformation(extent={{-100,80},{-80,100}})));
        Modelica.Blocks.Sources.Sine DHI(
          freqHz=1/(60*60*12),
          offset=100,
          amplitude=1000,
          phase=-1.5707963267949)
          annotation (Placement(transformation(extent={{-100,50},{-80,70}})));
        Modelica.Blocks.Sources.Sine DNI(
          amplitude=500,
          offset=500,
          freqHz=1/(60*60*12),
          phase=-1.5707963267949)
          annotation (Placement(transformation(extent={{-100,20},{-80,40}})));
        Modelica.Blocks.Sources.Constant One1(
                                             k=1)
          annotation (Placement(transformation(extent={{-10,-10},{10,10}},
              rotation=0,
              origin={-70,-20})));
        Buildings.BoundaryConditions.WeatherData.ReaderTMY3 weaDatInpCon(
          computeWetBulbTemperature=false,
          HSou=Buildings.BoundaryConditions.Types.RadiationDataSource.Input_HDirNor_HDifHor,
          TDryBulSou=Buildings.BoundaryConditions.Types.DataSource.Input,
          filNam="C:/Users/Christoph/Documents/SmartInverter/smartinverter_simulation/ExampleData/USA_CA_San.Francisco.Intl.AP.724940_TMY3_CONVERTED.mos")
          "Weather data reader with radiation data obtained from the inputs' connectors"
          annotation (Placement(transformation(extent={{-50,40},{-30,60}})));
        Modelica.Blocks.Math.UnitConversions.From_degC from_degC
          annotation (Placement(transformation(extent={{-76,84},{-64,96}})));
        Buildings.BoundaryConditions.WeatherData.ReaderTMY3 weaDatInpCon1(
          computeWetBulbTemperature=false, filNam="C:/Users/Christoph/Documents/SmartInverter/smartinverter_simulation/ExampleData/USA_CA_San.Francisco.Intl.AP.724940_TMY3_CONVERTED.mos")
          "Weather data reader with radiation data obtained from the inputs' connectors"
          annotation (Placement(transformation(extent={{-50,80},{-30,100}})));
        Buildings.Electrical.AC.ThreePhasesUnbalanced.Sources.FixedVoltage grid(f=
              60, V=208)
          annotation (Placement(transformation(extent={{80,8},{60,28}})));
        Interfaces.FLEXGRID_interface interface
          annotation (Placement(transformation(extent={{-20,-72},{20,-32}})));
      equation
        connect(flexgrid.scale1, One1.y) annotation (Line(points={{-22,4},{-52,4},{
                -52,-20},{-59,-20}}, color={0,0,127}));
        connect(flexgrid.scale2, One1.y) annotation (Line(points={{-22,0},{-52,0},{
                -52,-20},{-59,-20}}, color={0,0,127}));
        connect(flexgrid.scale3, One1.y) annotation (Line(points={{-22,-4},{-52,-4},{
                -52,-20},{-59,-20}}, color={0,0,127}));
        connect(Temperature.y, from_degC.u)
          annotation (Line(points={{-79,90},{-77.2,90}}, color={0,0,127}));
        connect(weaDatInpCon.TDryBul_in, from_degC.y) annotation (Line(points={{-51,
                59},{-51,74.5},{-63.4,74.5},{-63.4,90}}, color={0,0,127}));
        connect(weaDatInpCon.HDifHor_in, DHI.y) annotation (Line(points={{-51,42.4},{
                -59.5,42.4},{-59.5,60},{-79,60}}, color={0,0,127}));
        connect(weaDatInpCon.HDirNor_in, DNI.y) annotation (Line(points={{-51,39},{
                -56,39},{-56,40},{-60,40},{-60,30},{-79,30}}, color={0,0,127}));
        connect(weaDatInpCon1.weaBus, flexgrid.weaBus) annotation (Line(
            points={{-30,90},{-24,90},{-24,16},{-20,16}},
            color={255,204,51},
            thickness=0.5));
        connect(grid.terminal, flexgrid.terminal_p)
          annotation (Line(points={{60,18},{60,18},{22,18}}, color={0,120,120}));
        connect(flexgrid.invCtrlBus1, interface.invCtrlBus1) annotation (Line(
            points={{-10,-20},{-10,-26},{-10,-32}},
            color={255,204,51},
            thickness=0.5));
        connect(flexgrid.invCtrlBus2, interface.invCtrlBus2) annotation (Line(
            points={{0,-20},{0,-26},{0,-32}},
            color={255,204,51},
            thickness=0.5));
        connect(flexgrid.invCtrlBus3, interface.invCtrlBus3) annotation (Line(
            points={{10,-20},{10,-32}},
            color={255,204,51},
            thickness=0.5));
        connect(interface.batt_ctrl1, Zero.y) annotation (Line(points={{-22,-62},{
                -42,-62},{-42,-70},{-59,-70}}, color={0,0,127}));
        connect(interface.batt_ctrl2, Zero.y) annotation (Line(points={{-22,-66},{
                -42,-66},{-42,-70},{-59,-70}}, color={0,0,127}));
        connect(interface.batt_ctrl3, Zero.y)
          annotation (Line(points={{-22,-70},{-59,-70}}, color={0,0,127}));
        connect(One.y, interface.plim3)
          annotation (Line(points={{39,-90},{18,-90},{18,-74}}, color={0,0,127}));
        connect(interface.plim2, One.y) annotation (Line(points={{14,-74},{14,-74},
                {14,-90},{39,-90}}, color={0,0,127}));
        connect(interface.plim1, One.y) annotation (Line(points={{10,-74},{10,-74},
                {10,-90},{39,-90}}, color={0,0,127}));
        connect(interface.q_ctrl1, Zero.y) annotation (Line(points={{-6,-74},{-6,
                -74},{-6,-84},{-42,-84},{-42,-70},{-59,-70}}, color={0,0,127}));
        connect(interface.q_ctrl2, Zero.y) annotation (Line(points={{-2,-74},{-2,
                -74},{-2,-84},{-42,-84},{-42,-70},{-59,-70}}, color={0,0,127}));
        connect(interface.q_ctrl3, Zero.y) annotation (Line(points={{2,-74},{2,-74},
                {2,-84},{-42,-84},{-42,-70},{-59,-70}}, color={0,0,127}));
        annotation (Icon(coordinateSystem(preserveAspectRatio=false)),
        experiment(StartTime=2.09952e+07, StopTime=2.22039e+07),
        Diagram(coordinateSystem(preserveAspectRatio=false)));
      end Test_FLEXGRID;

      model Test_Inverter_voltvar
        "Example to test the functionality of a volt var control with inverter."
        extends Modelica.Icons.Example;
        Components.Inverter.Model.Inverter inverter(QIndmax=2500, QCapmax=1500)
          annotation (Placement(transformation(extent={{50,70},{30,90}})));
        Components.Controller.Model.voltvar voltvar
          annotation (Placement(transformation(extent={{0,-10},{20,10}})));
        Modelica.Blocks.Sources.Sine Voltage(
          offset=1,
          freqHz=1/5,
          amplitude=0.06)
          annotation (Placement(transformation(extent={{-100,12},{-80,32}})));
        Modelica.Blocks.Sources.Constant PV1(k=1000) annotation (Placement(
              transformation(
              extent={{-10,-10},{10,10}},
              rotation=0,
              origin={0,90})));
        Buildings.Electrical.AC.OnePhase.Sources.FixedVoltage fixVol(f=60, V=120,
          definiteReference=true)
          annotation (Placement(transformation(extent={{10,-10},{-10,10}},
              rotation=-90,
              origin={90,-90})));
        Modelica.Blocks.Sources.Constant Batt1(k=0) annotation (Placement(
              transformation(
              extent={{-10,-10},{10,10}},
              rotation=0,
              origin={0,60})));
        Modelica.Blocks.Sources.Constant Plim1(k=1) annotation (Placement(
              transformation(
              extent={{10,-10},{-10,10}},
              rotation=0,
              origin={60,30})));
        Modelica.Blocks.Sources.Constant Q_max(k=2500) annotation (Placement(
              transformation(
              extent={{-10,-10},{10,10}},
              rotation=0,
              origin={-10,30})));
        Modelica.Blocks.Sources.Constant upper_voltage(k=1.05)
          annotation (Placement(transformation(extent={{-72,52},{-52,72}})));
        Modelica.Blocks.Sources.Constant lower_voltage(k=0.95)
          annotation (Placement(transformation(extent={{-72,-68},{-52,-48}})));
        Modelica.Blocks.Sources.Constant upper_deadband_voltage(k=1.01)
          annotation (Placement(transformation(extent={{-60,12},{-40,32}})));
        Modelica.Blocks.Sources.Constant lower_deadband_voltage(k=0.99)
          annotation (Placement(transformation(extent={{-60,-28},{-40,-8}})));
        Modelica.Blocks.Sources.Ramp ramp(
          duration=1,
          startTime=0,
          height=0.2,
          offset=0.9)
          annotation (Placement(transformation(extent={{-100,-28},{-80,-8}})));
        Components.Inverter.Interfaces.InvCtrlBus          invCtrlBus annotation (
            Placement(transformation(extent={{30,40},{50,60}}),    iconTransformation(
                extent={{10,32},{30,52}})));
        Buildings.Electrical.AC.OnePhase.Lines.TwoPortRL RL1(R=1, L=1/(2*Modelica.Constants.pi
              *60)) annotation (Placement(transformation(
              extent={{10,-10},{-10,10}},
              rotation=270,
              origin={90,-56})));
        Buildings.Electrical.AC.OnePhase.Loads.Resistive load1(mode=Buildings.Electrical.Types.Load.VariableZ_P_input)
          annotation (Placement(transformation(extent={{80,-30},{60,-10}})));
        Modelica.Blocks.Sources.Sine Voltage1(
          freqHz=1/5,
          offset=-1500,
          amplitude=1500)
          annotation (Placement(transformation(extent={{20,-40},{40,-20}})));
        Buildings.Electrical.AC.OnePhase.Sensors.GeneralizedSensor sens annotation (
           Placement(transformation(
              extent={{-10,10},{10,-10}},
              rotation=90,
              origin={90,18})));
        Modelica.Blocks.Sources.RealExpression realExpression(y=sens.V/120)
          annotation (Placement(transformation(extent={{-80,-10},{-60,10}})));
        Buildings.Electrical.AC.OnePhase.Lines.TwoPortRL RL2(R=1, L=1/(2*Modelica.Constants.pi
              *60)) annotation (Placement(transformation(
              extent={{10,-10},{-10,10}},
              rotation=0,
              origin={70,-68})));
        Buildings.Electrical.AC.OnePhase.Loads.Resistive load2(mode=Buildings.Electrical.Types.Load.VariableZ_P_input)
          annotation (Placement(transformation(extent={{22,-70},{2,-50}})));
        Buildings.Electrical.AC.OnePhase.Sensors.GeneralizedSensor sens_ref
          annotation (Placement(transformation(
              extent={{-10,10},{10,-10}},
              rotation=180,
              origin={40,-70})));
        Buildings.Electrical.AC.OnePhase.Loads.Resistive load3(mode=Buildings.Electrical.Types.Load.VariableZ_P_input)
          annotation (Placement(transformation(extent={{22,-90},{2,-70}})));
        Modelica.Blocks.Sources.RealExpression realExpression1(y=PV1.y)
          annotation (Placement(transformation(extent={{-30,-90},{-10,-70}})));
      equation
        connect(inverter.P_Batt, inverter.batt_ctrl_inv) annotation (Line(points={{28,77},
                {28,77},{28,72},{29,72}},     color={0,0,127}));
        connect(inverter.P_PV, PV1.y) annotation (Line(points={{28,86},{18,86},{18,
                90},{11,90}},
                          color={0,0,127}));
        connect(Q_max.y, voltvar.q_maxcap)
          annotation (Line(points={{1,30},{6,30},{6,12}}, color={0,0,127}));
        connect(lower_voltage.y, voltvar.v_min) annotation (Line(points={{-51,-58},
                {-26,-58},{-26,-8},{-2,-8}},       color={0,0,127}));
        connect(upper_voltage.y, voltvar.v_max) annotation (Line(points={{-51,62},{
                -26,62},{-26,8},{-2,8}},       color={0,0,127}));
        connect(voltvar.v_mindead,lower_deadband_voltage. y) annotation (Line(
              points={{-2,-4},{-32,-4},{-32,-18},{-39,-18}},  color={0,0,127}));
        connect(upper_deadband_voltage.y, voltvar.v_maxdead) annotation (Line(
              points={{-39,22},{-32,22},{-32,4},{-2,4}},  color={0,0,127}));
        connect(invCtrlBus, inverter.invCtrlBus) annotation (Line(
            points={{40,50},{40,50},{40,60},{40,70}},
            color={255,204,51},
            thickness=0.5), Text(
            string="%first",
            index=-1,
            extent={{-6,3},{-6,3}}));
        connect(Batt1.y, invCtrlBus.batt_ctrl) annotation (Line(points={{11,60},{26,
                60},{26,50.05},{40.05,50.05}}, color={0,0,127}), Text(
            string="%second",
            index=1,
            extent={{6,3},{6,3}}));
        connect(Plim1.y, invCtrlBus.plim) annotation (Line(points={{49,30},{40.05,
                30},{40.05,50.05}}, color={0,0,127}), Text(
            string="%second",
            index=1,
            extent={{6,3},{6,3}}));
        connect(voltvar.q_control, invCtrlBus.qctrl) annotation (Line(points={{21,0},{
                40.05,0},{40.05,50.05}},  color={0,0,127}), Text(
            string="%second",
            index=1,
            extent={{6,3},{6,3}}));
        connect(voltvar.q_maxind, Q_max.y)
          annotation (Line(points={{12,12},{12,30},{1,30}}, color={0,0,127}));
        connect(fixVol.terminal, RL1.terminal_n) annotation (Line(points={{90,-80},
                {90,-73},{90,-66}}, color={0,120,120}));
        connect(Voltage1.y, load1.Pow) annotation (Line(points={{41,-30},{50,-30},{
                50,-20},{60,-20}}, color={0,0,127}));
        connect(sens.terminal_n, RL1.terminal_p)
          annotation (Line(points={{90,8},{90,8},{90,-46}}, color={0,120,120}));
        connect(load1.terminal, RL1.terminal_p) annotation (Line(points={{80,-20},{
                90,-20},{90,-46}}, color={0,120,120}));
        connect(realExpression.y, voltvar.v_pu)
          annotation (Line(points={{-59,0},{-30.5,0},{-2,0}}, color={0,0,127}));
        connect(sens.terminal_p, inverter.term_p) annotation (Line(points={{90,28},
                {90,28},{90,80},{50,80}}, color={0,120,120}));
        connect(RL2.terminal_n, RL1.terminal_n) annotation (Line(points={{80,-68},{
                86,-68},{86,-66},{90,-66}}, color={0,120,120}));
        connect(load2.Pow, Voltage1.y) annotation (Line(points={{2,-60},{2,-60},{2,
                -30},{41,-30}}, color={0,0,127}));
        connect(RL2.terminal_p, sens_ref.terminal_n) annotation (Line(points={{60,
                -68},{58,-68},{58,-70},{50,-70}}, color={0,120,120}));
        connect(sens_ref.terminal_p, load2.terminal) annotation (Line(points={{30,
                -70},{28,-70},{28,-60},{22,-60}}, color={0,120,120}));
        connect(load3.terminal, sens_ref.terminal_p) annotation (Line(points={{22,
                -80},{28,-80},{28,-70},{30,-70}}, color={0,120,120}));
        connect(realExpression1.y, load3.Pow)
          annotation (Line(points={{-9,-80},{-4,-80},{2,-80}}, color={0,0,127}));
        annotation (Icon(coordinateSystem(preserveAspectRatio=false)),
         experiment(StopTime=5), Diagram(
              coordinateSystem(preserveAspectRatio=false)));
      end Test_Inverter_voltvar;

      model Test_FLEXGRID_voltvar_FMU
        FLEXGRID_voltvar_FMU fLEXGRID_voltvar_FMU
          annotation (Placement(transformation(extent={{-20,-20},{20,20}})));
        Modelica.Blocks.Sources.Sine Voltage1(
          phase=0,
          offset=120,
          freqHz=1/5,
          amplitude=10)
          annotation (Placement(transformation(extent={{60,60},{40,80}})));
        Modelica.Blocks.Sources.Constant Scale(k=1) annotation (Placement(
              transformation(
              extent={{-10,-10},{10,10}},
              rotation=0,
              origin={-80,0})));
        Modelica.Blocks.Sources.Constant Batt_ctrl(k=0)
          annotation (Placement(transformation(extent={{-60,-40},{-40,-20}})));
        Modelica.Blocks.Sources.Constant Plim(
                                             k=1)
          annotation (Placement(transformation(extent={{-10,-10},{10,10}},
              rotation=90,
              origin={14,-50})));
        Modelica.Blocks.Sources.Constant f_fix(k=60) annotation (Placement(
              transformation(
              extent={{10,-10},{-10,10}},
              rotation=0,
              origin={70,0})));
        Modelica.Blocks.Sources.Constant v_fix1(k=120) annotation (Placement(
              transformation(
              extent={{10,-10},{-10,10}},
              rotation=0,
              origin={70,30})));
      equation
        connect(Scale.y, fLEXGRID_voltvar_FMU.scale2)
          annotation (Line(points={{-69,0},{-46,0},{-22,0}}, color={0,0,127}));
        connect(Scale.y, fLEXGRID_voltvar_FMU.scale3) annotation (Line(points={{-69,
                0},{-46,0},{-46,-4},{-22,-4}}, color={0,0,127}));
        connect(Scale.y, fLEXGRID_voltvar_FMU.scale1) annotation (Line(points={{-69,
                0},{-46,0},{-46,4},{-22,4}}, color={0,0,127}));
        connect(fLEXGRID_voltvar_FMU.batt_ctrl1, Batt_ctrl.y) annotation (Line(
              points={{-22,-10},{-32,-10},{-32,-30},{-39,-30}}, color={0,0,127}));
        connect(fLEXGRID_voltvar_FMU.batt_ctrl2, Batt_ctrl.y) annotation (Line(
              points={{-22,-14},{-32,-14},{-32,-30},{-39,-30}}, color={0,0,127}));
        connect(fLEXGRID_voltvar_FMU.batt_ctrl3, Batt_ctrl.y) annotation (Line(
              points={{-22,-17.6},{-32,-17.6},{-32,-30},{-39,-30}}, color={0,0,127}));
        connect(fLEXGRID_voltvar_FMU.plim1,Plim. y) annotation (Line(points={{10,-22},
                {10,-39},{14,-39}},            color={0,0,127}));
        connect(fLEXGRID_voltvar_FMU.plim2,Plim. y) annotation (Line(points={{14,-22},
                {14,-39}},                       color={0,0,127}));
        connect(f_fix.y, fLEXGRID_voltvar_FMU.f1) annotation (Line(points={{59,0},{
                40,0},{40,14},{22,14}}, color={0,0,127}));
        connect(f_fix.y, fLEXGRID_voltvar_FMU.f2)
          annotation (Line(points={{59,0},{40,0},{40,6},{22,6}}, color={0,0,127}));
        connect(f_fix.y, fLEXGRID_voltvar_FMU.f3) annotation (Line(points={{59,0},{
                40,0},{40,-2},{22,-2}}, color={0,0,127}));
        connect(v_fix1.y, fLEXGRID_voltvar_FMU.V2) annotation (Line(points={{59,30},
                {34,30},{34,10},{22,10}}, color={0,0,127}));
        connect(v_fix1.y, fLEXGRID_voltvar_FMU.V3) annotation (Line(points={{59,30},
                {52,30},{34,30},{34,2},{22,2}}, color={0,0,127}));
        connect(Plim.y, fLEXGRID_voltvar_FMU.plim3) annotation (Line(points={{14,
                -39},{16,-39},{18,-39},{18,-40},{18,-22}}, color={0,0,127}));
        connect(Voltage1.y, fLEXGRID_voltvar_FMU.V1) annotation (Line(points={{39,
                70},{32,70},{32,18},{22,18}}, color={0,0,127}));
        annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
              coordinateSystem(preserveAspectRatio=false)));
      end Test_FLEXGRID_voltvar_FMU;

      model Test_Inverter_voltvar_pf
        "Example to test the functionality of a volt var control with inverter."
        extends Modelica.Icons.Example;
        Components.Inverter.Model.Inverter_pf
                                           inverter(
          maxIndPf=0.1,
          maxCapPf=0.1,
          Qmax=2000)
          annotation (Placement(transformation(extent={{60,70},{40,90}})));
        Components.Controller.Model.voltvar voltvar
          annotation (Placement(transformation(extent={{0,-10},{20,10}})));
        Modelica.Blocks.Sources.Sine Voltage(
          offset=1,
          freqHz=1/5,
          amplitude=0.06)
          annotation (Placement(transformation(extent={{-100,10},{-80,30}})));
        Modelica.Blocks.Sources.Constant PV1(k=1000) annotation (Placement(
              transformation(
              extent={{-10,-10},{10,10}},
              rotation=0,
              origin={10,90})));
        Buildings.Electrical.AC.OnePhase.Sources.FixedVoltage fixVol(f=60, V=120)
          annotation (Placement(transformation(extent={{100,70},{80,90}})));
        Modelica.Blocks.Sources.Constant Batt1(k=0) annotation (Placement(
              transformation(
              extent={{-10,-10},{10,10}},
              rotation=0,
              origin={10,60})));
        Modelica.Blocks.Sources.Constant Plim1(k=1) annotation (Placement(
              transformation(
              extent={{10,-10},{-10,10}},
              rotation=0,
              origin={80,50})));
        Modelica.Blocks.Sources.Constant Q_max(k=2500) annotation (Placement(
              transformation(
              extent={{-10,-10},{10,10}},
              rotation=0,
              origin={-10,30})));
        Modelica.Blocks.Sources.Constant upper_voltage(k=1.05)
          annotation (Placement(transformation(extent={{-72,52},{-52,72}})));
        Modelica.Blocks.Sources.Constant lower_voltage(k=0.95)
          annotation (Placement(transformation(extent={{-72,-68},{-52,-48}})));
        Modelica.Blocks.Sources.Constant upper_deadband_voltage(k=1.01)
          annotation (Placement(transformation(extent={{-72,12},{-52,32}})));
        Modelica.Blocks.Sources.Constant lower_deadband_voltage(k=0.99)
          annotation (Placement(transformation(extent={{-72,-28},{-52,-8}})));
        Modelica.Blocks.Sources.Ramp ramp(
          duration=1,
          startTime=0,
          height=0.2,
          offset=0.9)
          annotation (Placement(transformation(extent={{-100,-30},{-80,-10}})));
        Components.Controller.Utility.QToPf qToPf
          annotation (Placement(transformation(extent={{30,-10},{50,10}})));
        Components.Inverter.Interfaces.InvCtrlBus_pf       invCtrlBus annotation (
            Placement(transformation(extent={{34,54},{44,64}}),    iconTransformation(
                extent={{10,32},{30,52}})));
      equation
        connect(inverter.term_p, fixVol.terminal)
          annotation (Line(points={{60,80},{70,80},{80,80}}, color={0,120,120}));
        connect(inverter.P_Batt, inverter.batt_ctrl_inv) annotation (Line(points={{38,
                77},{38,77},{38,72},{39,72}}, color={0,0,127}));
        connect(inverter.P_PV, PV1.y) annotation (Line(points={{38,86},{28,86},{28,90},
                {21,90}}, color={0,0,127}));
        connect(Q_max.y, voltvar.q_maxcap)
          annotation (Line(points={{1,30},{6,30},{6,12}}, color={0,0,127}));
        connect(voltvar.q_maxind, Q_max.y) annotation (Line(points={{12,12},{12,12},{12,
                30},{1,30}}, color={0,0,127}));
        connect(lower_voltage.y, voltvar.v_min) annotation (Line(points={{-51,-58},{-22,
                -58},{-22,-8},{-2,-8}},            color={0,0,127}));
        connect(upper_voltage.y, voltvar.v_max) annotation (Line(points={{-51,62},{-22,
                62},{-22,8},{-2,8}},           color={0,0,127}));
        connect(voltvar.v_mindead,lower_deadband_voltage. y) annotation (Line(
              points={{-2,-4},{-32,-4},{-32,-18},{-51,-18}},  color={0,0,127}));
        connect(upper_deadband_voltage.y, voltvar.v_maxdead) annotation (Line(
              points={{-51,22},{-32,22},{-32,4},{-2,4}},  color={0,0,127}));
        connect(voltvar.q_control, qToPf.q)
          annotation (Line(points={{21,0},{24.5,0},{28,0}}, color={0,0,127}));
        connect(inverter.p, qToPf.p) annotation (Line(points={{61,88},{62,88},{64,88},
                {64,28},{40,28},{40,12}}, color={0,0,127}));
        connect(voltvar.v_pu, Voltage.y) annotation (Line(points={{-2,0},{-76,0},{-76,
                20},{-79,20}}, color={0,0,127}));
        connect(invCtrlBus, inverter.invCtrlBus) annotation (Line(
            points={{39,59},{42,59},{42,70},{48,70}},
            color={255,204,51},
            thickness=0.5), Text(
            string="%first",
            index=-1,
            extent={{-6,3},{-6,3}}));
        connect(Batt1.y, invCtrlBus.batt_ctrl) annotation (Line(points={{21,60},{
                39.025,60},{39.025,59.025}}, color={0,0,127}), Text(
            string="%second",
            index=1,
            extent={{6,3},{6,3}}));
        connect(qToPf.pf, invCtrlBus.pf) annotation (Line(points={{51,0},{44,0},{44,
                59.025},{39.025,59.025}}, color={0,0,127}), Text(
            string="%second",
            index=1,
            extent={{6,3},{6,3}}));
        connect(Plim1.y, invCtrlBus.plim) annotation (Line(points={{69,50},{54,50},
                {54,59.025},{39.025,59.025}}, color={0,0,127}), Text(
            string="%second",
            index=1,
            extent={{6,3},{6,3}}));
        annotation (Icon(coordinateSystem(preserveAspectRatio=false)),
         experiment(StopTime=5), Diagram(
              coordinateSystem(preserveAspectRatio=false)));
      end Test_Inverter_voltvar_pf;

      model Test_FLEXGRID_FMU
        FLEXGRID_FMU fLEXGRID_FMU
          annotation (Placement(transformation(extent={{-20,-20},{20,20}})));
        Modelica.Blocks.Sources.Sine Voltage1(
          phase=0,
          offset=120,
          freqHz=1/5,
          amplitude=10)
          annotation (Placement(transformation(extent={{60,60},{40,80}})));
        Modelica.Blocks.Sources.Constant Scale(k=1) annotation (Placement(
              transformation(
              extent={{-10,-10},{10,10}},
              rotation=0,
              origin={-80,0})));
        Modelica.Blocks.Sources.Constant Batt_ctrl(k=0)
          annotation (Placement(transformation(extent={{-60,-40},{-40,-20}})));
        Modelica.Blocks.Sources.Constant Plim(
                                             k=1)
          annotation (Placement(transformation(extent={{-10,-10},{10,10}},
              rotation=90,
              origin={14,-50})));
        Modelica.Blocks.Sources.Constant f_fix(k=60) annotation (Placement(
              transformation(
              extent={{10,-10},{-10,10}},
              rotation=0,
              origin={70,0})));
        Modelica.Blocks.Sources.Constant v_fix1(k=120) annotation (Placement(
              transformation(
              extent={{10,-10},{-10,10}},
              rotation=0,
              origin={70,30})));
        Modelica.Blocks.Sources.Constant Q_ctrl(k=1000) annotation (Placement(
              transformation(
              extent={{-10,-10},{10,10}},
              rotation=90,
              origin={-20,-50})));
      equation
        connect(Scale.y, fLEXGRID_FMU.scale2)
          annotation (Line(points={{-69,0},{-46,0},{-22,0}}, color={0,0,127}));
        connect(Scale.y, fLEXGRID_FMU.scale3) annotation (Line(points={{-69,0},{-46,
                0},{-46,-4},{-22,-4}}, color={0,0,127}));
        connect(Scale.y, fLEXGRID_FMU.scale1) annotation (Line(points={{-69,0},{-46,
                0},{-46,4},{-22,4}}, color={0,0,127}));
        connect(fLEXGRID_FMU.batt_ctrl1, Batt_ctrl.y) annotation (Line(points={{-22,
                -10},{-32,-10},{-32,-30},{-39,-30}}, color={0,0,127}));
        connect(fLEXGRID_FMU.batt_ctrl2, Batt_ctrl.y) annotation (Line(points={{-22,
                -14},{-32,-14},{-32,-30},{-39,-30}}, color={0,0,127}));
        connect(fLEXGRID_FMU.batt_ctrl3, Batt_ctrl.y) annotation (Line(points={{-22,
                -17.6},{-32,-17.6},{-32,-30},{-39,-30}}, color={0,0,127}));
        connect(fLEXGRID_FMU.plim1, Plim.y)
          annotation (Line(points={{10,-22},{10,-39},{14,-39}}, color={0,0,127}));
        connect(fLEXGRID_FMU.plim2, Plim.y)
          annotation (Line(points={{14,-22},{14,-39}}, color={0,0,127}));
        connect(f_fix.y, fLEXGRID_FMU.f1) annotation (Line(points={{59,0},{40,0},{
                40,14},{22,14}}, color={0,0,127}));
        connect(f_fix.y, fLEXGRID_FMU.f2)
          annotation (Line(points={{59,0},{40,0},{40,6},{22,6}}, color={0,0,127}));
        connect(f_fix.y, fLEXGRID_FMU.f3) annotation (Line(points={{59,0},{40,0},{
                40,-2},{22,-2}}, color={0,0,127}));
        connect(v_fix1.y, fLEXGRID_FMU.V2) annotation (Line(points={{59,30},{34,30},
                {34,10},{22,10}}, color={0,0,127}));
        connect(v_fix1.y, fLEXGRID_FMU.V3) annotation (Line(points={{59,30},{52,30},
                {34,30},{34,2},{22,2}}, color={0,0,127}));
        connect(Plim.y, fLEXGRID_FMU.plim3) annotation (Line(points={{14,-39},{16,-39},
                {18,-39},{18,-40},{18,-22}}, color={0,0,127}));
        connect(Voltage1.y, fLEXGRID_FMU.V1) annotation (Line(points={{39,70},{32,
                70},{32,18},{22,18}}, color={0,0,127}));
        connect(fLEXGRID_FMU.q_ctrl1, Q_ctrl.y) annotation (Line(points={{-6,-22},{
                -6,-22},{-6,-40},{-6,-39},{-14,-39},{-20,-39}}, color={0,0,127}));
        connect(fLEXGRID_FMU.q_ctrl2, Q_ctrl.y) annotation (Line(points={{-2,-22},{
                -2,-22},{-2,-40},{-2,-39},{-12,-39},{-20,-39}}, color={0,0,127}));
        connect(fLEXGRID_FMU.q_ctrl3, Q_ctrl.y) annotation (Line(points={{2,-22},{2,
                -22},{2,-40},{2,-39},{-10,-39},{-20,-39}}, color={0,0,127}));
        annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
              coordinateSystem(preserveAspectRatio=false)));
      end Test_FLEXGRID_FMU;

      model Test_PVannual
        Components.Photovoltaics.Model.PVModule_simple pv1(
          n=1,
          lat=37.9,
          til=10,
          azi=0,
          A=0.5)
          annotation (Placement(transformation(extent={{-8,-10},{12,10}})));
        Buildings.BoundaryConditions.WeatherData.ReaderTMY3 weaDatInpCon1(
            computeWetBulbTemperature=false, filNam=
              "C:/Users/Christoph/Documents/SmartInverter/smartinverter_simulation/ExampleData/USA_CA_San.Francisco.Intl.AP.724940_TMY3.mos")
          "Weather data reader with radiation data obtained from the inputs' connectors"
          annotation (Placement(transformation(extent={{-60,40},{-40,60}})));
        Modelica.Blocks.Sources.Constant const(k=1)
          annotation (Placement(transformation(extent={{-60,-30},{-40,-10}})));
      equation
        connect(pv1.scale, const.y) annotation (Line(points={{-10,-4},{-24,-4},{-24,
                -20},{-39,-20}}, color={0,0,127}));
        connect(weaDatInpCon1.weaBus, pv1.weaBus) annotation (Line(
            points={{-40,50},{-24,50},{-24,4},{-8,4}},
            color={255,204,51},
            thickness=0.5));
        annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
              coordinateSystem(preserveAspectRatio=false)));
      end Test_PVannual;

      model Annual_Flexgrid
        generic_wye_voltvarwatt_simple generic_wye_voltvarwatt_simple1(weaName="C:/Users/Christoph/Documents/SmartInverter/smartinverter_simulation/ExampleData/USA_CA_San.Francisco.Intl.AP.724940_TMY3.mos")
          annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
        Buildings.Electrical.AC.ThreePhasesUnbalanced.Sources.FixedVoltage grid(f=60, V=
              120)
          annotation (Placement(transformation(extent={{80,-10},{60,10}})));
        Components.Inverter.Interfaces.InvCtrlBus invCtrlBus annotation (Placement(
              transformation(extent={{-110,-10},{-90,10}}),iconTransformation(extent={
                  {-110,-10},{-90,10}})));
      equation
        connect(generic_wye_voltvarwatt_simple1.terminal_p, grid.terminal)
          annotation (Line(points={{11,0},{60,0}}, color={0,120,120}));
        connect(invCtrlBus, generic_wye_voltvarwatt_simple1.invCtrlBus) annotation (
            Line(
            points={{-100,0},{-10,0}},
            color={255,204,51},
            thickness=0.5), Text(
            string="%first",
            index=-1,
            extent={{-6,3},{-6,3}},
            horizontalAlignment=TextAlignment.Right));
        annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
              coordinateSystem(preserveAspectRatio=false)));
      end Annual_Flexgrid;
    end Examples;

    package Interfaces

      model FLEXGRID_interface

        Modelica.Blocks.Interfaces.RealInput batt_ctrl3(start=0, unit="W")
          "Battery Power" annotation (Placement(transformation(
              origin={-110,52},
              extent={{10,10},{-10,-10}},
              rotation=180), iconTransformation(
              extent={{-10,-10},{10,10}},
              rotation=0,
              origin={-110,-90})));
        Modelica.Blocks.Interfaces.RealInput batt_ctrl1(start=0, unit="W")
          "Battery Power" annotation (Placement(transformation(
              origin={-110,80},
              extent={{10,10},{-10,-10}},
              rotation=180), iconTransformation(
              extent={{-10,-10},{10,10}},
              rotation=0,
              origin={-110,-50})));
        Modelica.Blocks.Interfaces.RealInput batt_ctrl2(start=0, unit="W")
          "Battery Power" annotation (Placement(transformation(
              origin={-110,66},
              extent={{10,10},{-10,-10}},
              rotation=180), iconTransformation(
              extent={{-10,-10},{10,10}},
              rotation=0,
              origin={-110,-70})));
        Modelica.Blocks.Interfaces.RealInput q_ctrl2(start=0, unit="var") "Reactive power control of inverter" annotation (Placement(transformation(
              origin={-110,10},
              extent={{10,10},{-10,-10}},
              rotation=180), iconTransformation(
              extent={{-10,-10},{10,10}},
              rotation=90,
              origin={-10,-110})));
        Modelica.Blocks.Interfaces.RealInput q_ctrl3(start=0, unit="var") "Reactive power control of inverter" annotation (Placement(transformation(
              origin={-110,-4},
              extent={{10,10},{-10,-10}},
              rotation=180), iconTransformation(
              extent={{-10,-10},{10,10}},
              rotation=90,
              origin={10,-110})));
        Modelica.Blocks.Interfaces.RealInput q_ctrl1(start=0, unit="var") "Reactive power control of inverter" annotation (Placement(transformation(
              origin={-110,24},
              extent={{10,10},{-10,-10}},
              rotation=180), iconTransformation(
              extent={{-10,-10},{10,10}},
              rotation=90,
              origin={-30,-110})));
        Modelica.Blocks.Interfaces.RealInput plim3(
          start=1,
          min=0,
          max=1,
          unit="1") "Power Limit of Inverter" annotation (Placement(transformation(
              origin={-110,-58},
              extent={{10,10},{-10,-10}},
              rotation=180), iconTransformation(
              extent={{-10,-10},{10,10}},
              rotation=90,
              origin={90,-110})));
        Modelica.Blocks.Interfaces.RealInput plim2(
          start=1,
          min=0,
          max=1,
          unit="1") "Power Limit of Inverter" annotation (Placement(transformation(
              origin={-110,-44},
              extent={{10,10},{-10,-10}},
              rotation=180), iconTransformation(
              extent={{-10,-10},{10,10}},
              rotation=90,
              origin={70,-110})));
        Modelica.Blocks.Interfaces.RealInput plim1(
          start=1,
          min=0,
          max=1,
          unit="1") "Power Limit of Inverter" annotation (Placement(transformation(
              origin={-110,-30},
              extent={{10,10},{-10,-10}},
              rotation=180), iconTransformation(
              extent={{-10,-10},{10,10}},
              rotation=90,
              origin={50,-110})));
        Components.Inverter.Interfaces.InvCtrlBus invCtrlBus1 annotation (Placement(
              transformation(extent={{-50,90},{-30,110}}),
                                                         iconTransformation(extent={{
                  -60,90},{-40,110}})));
        Components.Inverter.Interfaces.InvCtrlBus invCtrlBus2 annotation (Placement(
              transformation(extent={{-10,90},{10,110}}), iconTransformation(extent={
                  {-10,90},{10,110}})));
        Components.Inverter.Interfaces.InvCtrlBus invCtrlBus3 annotation (Placement(
              transformation(extent={{40,90},{60,110}}),   iconTransformation(extent={{40,90},
                  {60,110}})));
        Modelica.Blocks.Interfaces.RealOutput p1(start=0, unit="W")
                                                                   "active power output [W]"
          annotation (Placement(transformation(extent={{100,80},{120,100}}),
              iconTransformation(extent={{100,80},{120,100}})));
        Modelica.Blocks.Interfaces.RealOutput q1(start=0, unit="var") "reactive power output [var]"
          annotation (Placement(transformation(extent={{100,60},{120,80}}),
              iconTransformation(extent={{100,60},{120,80}})));
        Modelica.Blocks.Interfaces.RealOutput p2(start=0, unit="W")
                                                                   "active power output [W]"
          annotation (Placement(transformation(extent={{100,20},{120,40}}),
              iconTransformation(extent={{100,20},{120,40}})));
        Modelica.Blocks.Interfaces.RealOutput q2(start=0, unit="var") "reactive power output [var]"
          annotation (Placement(transformation(extent={{100,0},{120,20}}),
              iconTransformation(extent={{100,0},{120,20}})));
        Modelica.Blocks.Interfaces.RealOutput p3(start=0, unit="W")
                                                                   "active power output [W]"
          annotation (Placement(transformation(extent={{100,-40},{120,-20}}),
              iconTransformation(extent={{100,-40},{120,-20}})));
        Modelica.Blocks.Interfaces.RealOutput q3(start=0, unit="var") "reactive power output [var]"
          annotation (Placement(transformation(extent={{100,-60},{120,-40}}),
              iconTransformation(extent={{100,-60},{120,-40}})));
      equation
        connect(batt_ctrl1, invCtrlBus1.batt_ctrl) annotation (Line(points={{-110,80},
                {-40,80},{-40,100.05},{-39.95,100.05}},
                                                      color={0,0,127}), Text(
            string="%second",
            index=1,
            extent={{6,3},{6,3}}));
        connect(plim1, invCtrlBus1.plim) annotation (Line(points={{-110,-30},{-76,-30},
                {-76,-28},{-40,-28},{-40,100.05},{-39.95,100.05}},
                                             color={0,0,127}), Text(
            string="%second",
            index=1,
            extent={{6,3},{6,3}}));
        connect(batt_ctrl2, invCtrlBus2.batt_ctrl) annotation (Line(points={{-110,66},
                {0,66},{0,100.05},{0.05,100.05}}, color={0,0,127}), Text(
            string="%second",
            index=1,
            extent={{6,3},{6,3}}));
        connect(plim2, invCtrlBus2.plim) annotation (Line(points={{-110,-44},{0,-44},
                {0,100.05},{0.05,100.05}}, color={0,0,127}), Text(
            string="%second",
            index=1,
            extent={{6,3},{6,3}}));
        connect(batt_ctrl3, invCtrlBus3.batt_ctrl) annotation (Line(points={{-110,52},
                {40,52},{40,100.05},{50.05,100.05}},  color={0,0,127}), Text(
            string="%second",
            index=1,
            extent={{6,3},{6,3}}));
        connect(plim3, invCtrlBus3.plim) annotation (Line(points={{-110,-58},{40,-58},
                {40,100.05},{50.05,100.05}},  color={0,0,127}), Text(
            string="%second",
            index=1,
            extent={{6,3},{6,3}}));
        connect(q1, invCtrlBus1.q) annotation (Line(points={{110,70},{-40,70},{-40,
                100.05},{-39.95,100.05}}, color={0,0,127}), Text(
            string="%second",
            index=1,
            extent={{6,3},{6,3}}));
        connect(p1, invCtrlBus1.p) annotation (Line(points={{110,90},{36,90},{36,90},
                {-40,90},{-40,100.05},{-39.95,100.05}}, color={0,0,127}), Text(
            string="%second",
            index=1,
            extent={{6,3},{6,3}}));
        connect(p2, invCtrlBus2.p) annotation (Line(points={{110,30},{0,30},{0,100.05},
                {0.05,100.05}}, color={0,0,127}), Text(
            string="%second",
            index=1,
            extent={{6,3},{6,3}}));
        connect(q2, invCtrlBus2.q) annotation (Line(points={{110,10},{0,10},{0,100.05},
                {0.05,100.05}}, color={0,0,127}), Text(
            string="%second",
            index=1,
            extent={{6,3},{6,3}}));
        connect(p3, invCtrlBus3.p) annotation (Line(points={{110,-30},{40,-30},{40,
                100.05},{50.05,100.05}}, color={0,0,127}), Text(
            string="%second",
            index=1,
            extent={{6,3},{6,3}}));
        connect(q3, invCtrlBus3.q) annotation (Line(points={{110,-50},{40,-50},{40,
                100.05},{50.05,100.05}}, color={0,0,127}), Text(
            string="%second",
            index=1,
            extent={{6,3},{6,3}}));
        connect(q_ctrl1, invCtrlBus1.qctrl) annotation (Line(points={{-110,24},{-76,
                24},{-76,24},{-40,24},{-40,100.05},{-39.95,100.05}}, color={0,0,127}),
            Text(
            string="%second",
            index=1,
            extent={{6,3},{6,3}}));
        connect(q_ctrl2, invCtrlBus2.qctrl) annotation (Line(points={{-110,10},{0,10},
                {0,100.05},{0.05,100.05}}, color={0,0,127}), Text(
            string="%second",
            index=1,
            extent={{6,3},{6,3}}));
        connect(q_ctrl3, invCtrlBus3.qctrl) annotation (Line(points={{-110,-4},{40,-4},
                {40,100.05},{50.05,100.05}}, color={0,0,127}), Text(
            string="%second",
            index=1,
            extent={{6,3},{6,3}}));
        annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
              coordinateSystem(preserveAspectRatio=false)));
      end FLEXGRID_interface;

      model FLEXGRID_interface_voltvar
        parameter Real V_nominal(min=0, unit="V") = 120 "Nominal sytem voltage to scale Vp.u.";
        parameter Real v_max( start=1.05, unit="1")=1.05 "Voltage maximum [p.u.]";
        parameter Real v_maxdead( start=1.01, unit="1")=1.01 "Upper bound of deadband [p.u.]";
        parameter Real v_mindead( start=0.99, unit="1")=0.99 "Lower bound of deadband [p.u.]";
        parameter Real v_min( start=0.95, unit="1")=0.95 "Voltage minimum [p.u.]";
        parameter Real q_maxind( start=1000, unit="var")=1000 "Maximal Reactive Power (Inductive) [var]";
        parameter Real q_maxcap( start=1000, unit="var")=1000 "Maximal Reactive Power (Capacitive) [var]";
        Modelica.Blocks.Interfaces.RealInput batt_ctrl3(start=0, unit="W")
          "Battery Power" annotation (Placement(transformation(
              origin={-110,52},
              extent={{10,10},{-10,-10}},
              rotation=180), iconTransformation(
              extent={{-10,-10},{10,10}},
              rotation=0,
              origin={-110,-90})));
        Modelica.Blocks.Interfaces.RealInput batt_ctrl1(start=0, unit="W")
          "Battery Power" annotation (Placement(transformation(
              origin={-110,80},
              extent={{10,10},{-10,-10}},
              rotation=180), iconTransformation(
              extent={{-10,-10},{10,10}},
              rotation=0,
              origin={-110,-50})));
        Modelica.Blocks.Interfaces.RealInput batt_ctrl2(start=0, unit="W")
          "Battery Power" annotation (Placement(transformation(
              origin={-110,66},
              extent={{10,10},{-10,-10}},
              rotation=180), iconTransformation(
              extent={{-10,-10},{10,10}},
              rotation=0,
              origin={-110,-70})));
        Modelica.Blocks.Interfaces.RealInput plim3(
          start=1,
          min=0,
          max=1,
          unit="1") "Power Limit of Inverter" annotation (Placement(transformation(
              origin={-110,-58},
              extent={{10,10},{-10,-10}},
              rotation=180), iconTransformation(
              extent={{-10,-10},{10,10}},
              rotation=90,
              origin={90,-110})));
        Modelica.Blocks.Interfaces.RealInput plim2(
          start=1,
          min=0,
          max=1,
          unit="1") "Power Limit of Inverter" annotation (Placement(transformation(
              origin={-110,-44},
              extent={{10,10},{-10,-10}},
              rotation=180), iconTransformation(
              extent={{-10,-10},{10,10}},
              rotation=90,
              origin={70,-110})));
        Modelica.Blocks.Interfaces.RealInput plim1(
          start=1,
          min=0,
          max=1,
          unit="1") "Power Limit of Inverter" annotation (Placement(transformation(
              origin={-110,-30},
              extent={{10,10},{-10,-10}},
              rotation=180), iconTransformation(
              extent={{-10,-10},{10,10}},
              rotation=90,
              origin={50,-110})));
        Components.Inverter.Interfaces.InvCtrlBus invCtrlBus1 annotation (Placement(
              transformation(extent={{-50,90},{-30,110}}),
                                                         iconTransformation(extent={{
                  -60,90},{-40,110}})));
        Components.Inverter.Interfaces.InvCtrlBus invCtrlBus2 annotation (Placement(
              transformation(extent={{-10,90},{10,110}}), iconTransformation(extent={
                  {-10,90},{10,110}})));
        Components.Inverter.Interfaces.InvCtrlBus invCtrlBus3 annotation (Placement(
              transformation(extent={{40,90},{60,110}}),   iconTransformation(extent={{40,90},
                  {60,110}})));
        Modelica.Blocks.Interfaces.RealOutput p1(start=0, unit="W")
                                                                   "active power output [W]"
          annotation (Placement(transformation(extent={{100,80},{120,100}}),
              iconTransformation(extent={{100,80},{120,100}})));
        Modelica.Blocks.Interfaces.RealOutput q1(start=0, unit="var") "reactive power output [var]"
          annotation (Placement(transformation(extent={{100,60},{120,80}}),
              iconTransformation(extent={{100,60},{120,80}})));
        Modelica.Blocks.Interfaces.RealOutput p2(start=0, unit="W")
                                                                   "active power output [W]"
          annotation (Placement(transformation(extent={{100,20},{120,40}}),
              iconTransformation(extent={{100,20},{120,40}})));
        Modelica.Blocks.Interfaces.RealOutput q2(start=0, unit="var") "reactive power output [var]"
          annotation (Placement(transformation(extent={{100,0},{120,20}}),
              iconTransformation(extent={{100,0},{120,20}})));
        Modelica.Blocks.Interfaces.RealOutput p3(start=0, unit="W")
                                                                   "active power output [W]"
          annotation (Placement(transformation(extent={{100,-40},{120,-20}}),
              iconTransformation(extent={{100,-40},{120,-20}})));
        Modelica.Blocks.Interfaces.RealOutput q3(start=0, unit="var") "reactive power output [var]"
          annotation (Placement(transformation(extent={{100,-60},{120,-40}}),
              iconTransformation(extent={{100,-60},{120,-40}})));
        Components.Controller.Model.voltvar_param_bus voltvar1(
          V_nominal=V_nominal,
          v_max=v_max,
          v_maxdead=v_maxdead,
          v_mindead=v_mindead,
          v_min=v_min,
          q_maxind=q_maxind,
          q_maxcap=q_maxcap) annotation (Placement(transformation(
              extent={{-10,-10},{10,10}},
              rotation=90,
              origin={-40,-80})));
        Components.Controller.Model.voltvar_param_bus voltvar2(
          V_nominal=V_nominal,
          v_max=v_max,
          v_maxdead=v_maxdead,
          v_mindead=v_mindead,
          v_min=v_min,
          q_maxind=q_maxind,
          q_maxcap=q_maxcap) annotation (Placement(transformation(
              extent={{-10,-10},{10,10}},
              rotation=90,
              origin={0,-80})));
        Components.Controller.Model.voltvar_param_bus voltvar3(
          V_nominal=V_nominal,
          v_max=v_max,
          v_maxdead=v_maxdead,
          v_mindead=v_mindead,
          v_min=v_min,
          q_maxind=q_maxind,
          q_maxcap=q_maxcap) annotation (Placement(transformation(
              extent={{-10,-10},{10,10}},
              rotation=90,
              origin={40,-80})));
      equation
        connect(batt_ctrl1, invCtrlBus1.batt_ctrl) annotation (Line(points={{-110,80},
                {-40,80},{-40,100.05},{-39.95,100.05}},
                                                      color={0,0,127}), Text(
            string="%second",
            index=1,
            extent={{6,3},{6,3}}));
        connect(plim1, invCtrlBus1.plim) annotation (Line(points={{-110,-30},{-76,-30},
                {-76,-30},{-40,-30},{-40,100.05},{-39.95,100.05}},
                                             color={0,0,127}), Text(
            string="%second",
            index=1,
            extent={{6,3},{6,3}}));
        connect(batt_ctrl2, invCtrlBus2.batt_ctrl) annotation (Line(points={{-110,66},
                {0,66},{0,100.05},{0.05,100.05}}, color={0,0,127}), Text(
            string="%second",
            index=1,
            extent={{6,3},{6,3}}));
        connect(plim2, invCtrlBus2.plim) annotation (Line(points={{-110,-44},{0,-44},
                {0,100.05},{0.05,100.05}}, color={0,0,127}), Text(
            string="%second",
            index=1,
            extent={{6,3},{6,3}}));
        connect(batt_ctrl3, invCtrlBus3.batt_ctrl) annotation (Line(points={{-110,52},
                {40,52},{40,100.05},{50.05,100.05}},  color={0,0,127}), Text(
            string="%second",
            index=1,
            extent={{6,3},{6,3}}));
        connect(plim3, invCtrlBus3.plim) annotation (Line(points={{-110,-58},{40,-58},
                {40,100.05},{50.05,100.05}},  color={0,0,127}), Text(
            string="%second",
            index=1,
            extent={{6,3},{6,3}}));
        connect(q1, invCtrlBus1.q) annotation (Line(points={{110,70},{-40,70},{-40,100.05},
                {-39.95,100.05}}, color={0,0,127}), Text(
            string="%second",
            index=1,
            extent={{6,3},{6,3}}));
        connect(p1, invCtrlBus1.p) annotation (Line(points={{110,90},{36,90},{36,90},{
                -40,90},{-40,100.05},{-39.95,100.05}}, color={0,0,127}), Text(
            string="%second",
            index=1,
            extent={{6,3},{6,3}}));
        connect(p2, invCtrlBus2.p) annotation (Line(points={{110,30},{0,30},{0,100.05},
                {0.05,100.05}}, color={0,0,127}), Text(
            string="%second",
            index=1,
            extent={{6,3},{6,3}}));
        connect(q2, invCtrlBus2.q) annotation (Line(points={{110,10},{0,10},{0,100.05},
                {0.05,100.05}}, color={0,0,127}), Text(
            string="%second",
            index=1,
            extent={{6,3},{6,3}}));
        connect(p3, invCtrlBus3.p) annotation (Line(points={{110,-30},{40,-30},{40,100.05},
                {50.05,100.05}}, color={0,0,127}), Text(
            string="%second",
            index=1,
            extent={{6,3},{6,3}}));
        connect(q3, invCtrlBus3.q) annotation (Line(points={{110,-50},{40,-50},{40,100.05},
                {50.05,100.05}}, color={0,0,127}), Text(
            string="%second",
            index=1,
            extent={{6,3},{6,3}}));
        connect(voltvar1.invCtrlBus, invCtrlBus1) annotation (Line(
            points={{-40,-70},{-40,100}},
            color={255,204,51},
            thickness=0.5), Text(
            string="%second",
            index=1,
            extent={{6,3},{6,3}}));
        connect(voltvar2.invCtrlBus, invCtrlBus2) annotation (Line(
            points={{0,-70},{0,-70},{0,100}},
            color={255,204,51},
            thickness=0.5), Text(
            string="%second",
            index=1,
            extent={{6,3},{6,3}}));
        connect(voltvar3.invCtrlBus, invCtrlBus3) annotation (Line(
            points={{40,-70},{40,-70},{40,100},{50,100}},
            color={255,204,51},
            thickness=0.5), Text(
            string="%second",
            index=1,
            extent={{6,3},{6,3}}));
        annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
              coordinateSystem(preserveAspectRatio=false)));
      end FLEXGRID_interface_voltvar;

      model generic_interface_voltvar
        parameter Real V_nominal(min=0, unit="V") = 120 "Nominal sytem voltage to scale Vp.u.";
        parameter Real v_max( start=1.05, unit="1")=1.05 "Voltage maximum [p.u.]";
        parameter Real v_maxdead( start=1.01, unit="1")=1.01 "Upper bound of deadband [p.u.]";
        parameter Real v_mindead( start=0.99, unit="1")=0.99 "Lower bound of deadband [p.u.]";
        parameter Real v_min( start=0.95, unit="1")=0.95 "Voltage minimum [p.u.]";
        parameter Real q_maxind( start=1000, unit="var")=1000 "Maximal Reactive Power (Inductive) [var]";
        parameter Real q_maxcap( start=1000, unit="var")=1000 "Maximal Reactive Power (Capacitive) [var]";
        Components.Inverter.Interfaces.InvCtrlBus invCtrlBus1 annotation (Placement(
              transformation(extent={{-50,90},{-30,110}}),
                                                         iconTransformation(extent={{
                  -60,90},{-40,110}})));
        Components.Inverter.Interfaces.InvCtrlBus invCtrlBus2 annotation (Placement(
              transformation(extent={{-10,90},{10,110}}), iconTransformation(extent={
                  {-10,90},{10,110}})));
        Components.Inverter.Interfaces.InvCtrlBus invCtrlBus3 annotation (Placement(
              transformation(extent={{40,90},{60,110}}),   iconTransformation(extent={{40,90},
                  {60,110}})));
        Modelica.Blocks.Interfaces.RealOutput p1(start=0, unit="W")
                                                                   "active power output [W]"
          annotation (Placement(transformation(extent={{100,80},{120,100}}),
              iconTransformation(extent={{100,80},{120,100}})));
        Modelica.Blocks.Interfaces.RealOutput q1(start=0, unit="var") "reactive power output [var]"
          annotation (Placement(transformation(extent={{100,60},{120,80}}),
              iconTransformation(extent={{100,60},{120,80}})));
        Modelica.Blocks.Interfaces.RealOutput p2(start=0, unit="W")
                                                                   "active power output [W]"
          annotation (Placement(transformation(extent={{100,20},{120,40}}),
              iconTransformation(extent={{100,20},{120,40}})));
        Modelica.Blocks.Interfaces.RealOutput q2(start=0, unit="var") "reactive power output [var]"
          annotation (Placement(transformation(extent={{100,0},{120,20}}),
              iconTransformation(extent={{100,0},{120,20}})));
        Modelica.Blocks.Interfaces.RealOutput p3(start=0, unit="W")
                                                                   "active power output [W]"
          annotation (Placement(transformation(extent={{100,-40},{120,-20}}),
              iconTransformation(extent={{100,-40},{120,-20}})));
        Modelica.Blocks.Interfaces.RealOutput q3(start=0, unit="var") "reactive power output [var]"
          annotation (Placement(transformation(extent={{100,-60},{120,-40}}),
              iconTransformation(extent={{100,-60},{120,-40}})));
        Components.Controller.Model.voltvar_param_bus voltvar1(
          V_nominal=V_nominal,
          v_max=v_max,
          v_maxdead=v_maxdead,
          v_mindead=v_mindead,
          v_min=v_min,
          q_maxind=q_maxind,
          q_maxcap=q_maxcap) annotation (Placement(transformation(
              extent={{-10,-10},{10,10}},
              rotation=90,
              origin={-40,-80})));
        Components.Controller.Model.voltvar_param_bus voltvar2(
          V_nominal=V_nominal,
          v_max=v_max,
          v_maxdead=v_maxdead,
          v_mindead=v_mindead,
          v_min=v_min,
          q_maxind=q_maxind,
          q_maxcap=q_maxcap) annotation (Placement(transformation(
              extent={{-10,-10},{10,10}},
              rotation=90,
              origin={0,-80})));
        Components.Controller.Model.voltvar_param_bus voltvar3(
          V_nominal=V_nominal,
          v_max=v_max,
          v_maxdead=v_maxdead,
          v_mindead=v_mindead,
          v_min=v_min,
          q_maxind=q_maxind,
          q_maxcap=q_maxcap) annotation (Placement(transformation(
              extent={{-10,-10},{10,10}},
              rotation=90,
              origin={40,-80})));
        Components.Inverter.Interfaces.InvCtrlBus invCtrlBus annotation (Placement(
              transformation(extent={{-120,-20},{-80,20}}), iconTransformation(extent=
                 {{-110,-10},{-90,10}})));
        Modelica.Blocks.Sources.RealExpression activePower(y=p1 + p2 + p3)
          annotation (Placement(transformation(extent={{-50,40},{-80,60}})));
        Modelica.Blocks.Sources.RealExpression reactivePower1(y=q1 + q2 + q3)
          annotation (Placement(transformation(extent={{-50,20},{-80,40}})));
        Modelica.Blocks.Sources.Constant const_voltage(k=0)
          annotation (Placement(transformation(extent={{-60,-40},{-80,-20}})));
      equation
        connect(q1, invCtrlBus1.q) annotation (Line(points={{110,70},{-40,70},{-40,100.05},
                {-39.95,100.05}}, color={0,0,127}), Text(
            string="%second",
            index=1,
            extent={{6,3},{6,3}}));
        connect(p1, invCtrlBus1.p) annotation (Line(points={{110,90},{36,90},{36,90},{
                -40,90},{-40,100.05},{-39.95,100.05}}, color={0,0,127}), Text(
            string="%second",
            index=1,
            extent={{6,3},{6,3}}));
        connect(p2, invCtrlBus2.p) annotation (Line(points={{110,30},{0,30},{0,100.05},
                {0.05,100.05}}, color={0,0,127}), Text(
            string="%second",
            index=1,
            extent={{6,3},{6,3}}));
        connect(q2, invCtrlBus2.q) annotation (Line(points={{110,10},{0,10},{0,100.05},
                {0.05,100.05}}, color={0,0,127}), Text(
            string="%second",
            index=1,
            extent={{6,3},{6,3}}));
        connect(p3, invCtrlBus3.p) annotation (Line(points={{110,-30},{40,-30},{40,100.05},
                {50.05,100.05}}, color={0,0,127}), Text(
            string="%second",
            index=1,
            extent={{6,3},{6,3}}));
        connect(q3, invCtrlBus3.q) annotation (Line(points={{110,-50},{40,-50},{40,100.05},
                {50.05,100.05}}, color={0,0,127}), Text(
            string="%second",
            index=1,
            extent={{6,3},{6,3}}));
        connect(voltvar1.invCtrlBus, invCtrlBus1) annotation (Line(
            points={{-40,-70},{-40,100}},
            color={255,204,51},
            thickness=0.5), Text(
            string="%second",
            index=1,
            extent={{6,3},{6,3}}));
        connect(voltvar2.invCtrlBus, invCtrlBus2) annotation (Line(
            points={{0,-70},{0,-70},{0,100}},
            color={255,204,51},
            thickness=0.5), Text(
            string="%second",
            index=1,
            extent={{6,3},{6,3}}));
        connect(voltvar3.invCtrlBus, invCtrlBus3) annotation (Line(
            points={{40,-70},{40,-70},{40,100},{50,100}},
            color={255,204,51},
            thickness=0.5), Text(
            string="%second",
            index=1,
            extent={{6,3},{6,3}}));
        connect(invCtrlBus1.plim, invCtrlBus.plim) annotation (
          Line(
            points={{-39.95,100.05},{-40,100.05},{-40,0},{-70,0},{-70,0.1},{-99.9,0.1}},
            color={255,204,51},
            thickness=0.5),
          Text(
            string="%first",
            index=1,
            extent={{-6,3},{-6,3}},
            horizontalAlignment=TextAlignment.Right),
          Text(
            string="%second",
            index=-1,
            extent={{6,3},{6,3}},
            horizontalAlignment=TextAlignment.Left));

        connect(invCtrlBus1.batt_ctrl, invCtrlBus.batt_ctrl) annotation (
          Line(
            points={{-39.95,100.05},{-40,100.05},{-40,0},{-70,0},{-70,0.1},{-99.9,0.1}},
            color={255,204,51},
            thickness=0.5),
          Text(
            string="%first",
            index=1,
            extent={{-6,3},{-6,3}},
            horizontalAlignment=TextAlignment.Right),
          Text(
            string="%second",
            index=-1,
            extent={{6,3},{6,3}},
            horizontalAlignment=TextAlignment.Left));

        connect(invCtrlBus2.plim, invCtrlBus.plim) annotation (
          Line(
            points={{0.05,100.05},{0,100.05},{0,0},{-50,0},{-50,0.1},{-99.9,0.1}},
            color={255,204,51},
            thickness=0.5),
          Text(
            string="%first",
            index=1,
            extent={{-6,3},{-6,3}},
            horizontalAlignment=TextAlignment.Right),
          Text(
            string="%second",
            index=-1,
            extent={{6,3},{6,3}},
            horizontalAlignment=TextAlignment.Left));
        connect(invCtrlBus2.batt_ctrl, invCtrlBus.batt_ctrl) annotation (
          Line(
            points={{0.05,100.05},{0,100.05},{0,0},{-50,0},{-50,0.1},{-99.9,0.1}},
            color={255,204,51},
            thickness=0.5),
          Text(
            string="%first",
            index=1,
            extent={{-6,3},{-6,3}},
            horizontalAlignment=TextAlignment.Right),
          Text(
            string="%second",
            index=-1,
            extent={{6,3},{6,3}},
            horizontalAlignment=TextAlignment.Left));
        connect(invCtrlBus3.plim, invCtrlBus.plim) annotation (
          Line(
            points={{50.05,100.05},{40,100.05},{40,0},{-30,0},{-30,0.1},{-99.9,0.1}},
            color={255,204,51},
            thickness=0.5),
          Text(
            string="%first",
            index=1,
            extent={{-6,3},{-6,3}},
            horizontalAlignment=TextAlignment.Right),
          Text(
            string="%second",
            index=-1,
            extent={{6,3},{6,3}},
            horizontalAlignment=TextAlignment.Left));

        connect(invCtrlBus3.batt_ctrl, invCtrlBus.batt_ctrl) annotation (
          Line(
            points={{50.05,100.05},{40,100.05},{40,0},{-30,0},{-30,0.1},{-99.9,0.1}},
            color={255,204,51},
            thickness=0.5),
          Text(
            string="%first",
            index=1,
            extent={{-6,3},{-6,3}},
            horizontalAlignment=TextAlignment.Right),
          Text(
            string="%second",
            index=-1,
            extent={{6,3},{6,3}},
            horizontalAlignment=TextAlignment.Left));

        connect(reactivePower1.y, invCtrlBus.q) annotation (Line(points={{-81.5,30},{
                -88,30},{-88,0.1},{-99.9,0.1}}, color={0,0,127}), Text(
            string="%second",
            index=1,
            extent={{-6,3},{-6,3}},
            horizontalAlignment=TextAlignment.Right));
        connect(activePower.y, invCtrlBus.p) annotation (Line(points={{-81.5,50},{-88,
                50},{-88,0.1},{-99.9,0.1}}, color={0,0,127}), Text(
            string="%second",
            index=1,
            extent={{-6,3},{-6,3}},
            horizontalAlignment=TextAlignment.Right));
        connect(const_voltage.y, invCtrlBus.v) annotation (Line(points={{-81,-30},{
                -88,-30},{-88,0.1},{-99.9,0.1}}, color={0,0,127}), Text(
            string="%second",
            index=1,
            extent={{-6,3},{-6,3}},
            horizontalAlignment=TextAlignment.Right));
        annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
              coordinateSystem(preserveAspectRatio=false)));
      end generic_interface_voltvar;
    end Interfaces;

    model FLEXGRID_pf_FMU

      FLEXGRID flexgrid
        annotation (Placement(transformation(extent={{-20,20},{20,60}})));
      Buildings.BoundaryConditions.WeatherData.ReaderTMY3 weaDatInpCon1(
        computeWetBulbTemperature=false, filNam="C:/Users/Christoph/Documents/SmartInverter/smartinverter_simulation/ExampleData/USA_CA_San.Francisco.Intl.AP.724940_TMY3_CONVERTED.mos")
        "Weather data reader with radiation data obtained from the inputs' connectors"
        annotation (Placement(transformation(extent={{-80,70},{-60,90}})));
      Modelica.Blocks.Interfaces.RealInput scale3(start=1,
        min=0,
        max=1,
        unit="1") "Shading of PV module" annotation (Placement(transformation(
            origin={-110,12},
            extent={{10,10},{-10,-10}},
            rotation=180), iconTransformation(
            extent={{-10,-10},{10,10}},
            rotation=0,
            origin={-110,-20})));
      Modelica.Blocks.Interfaces.RealInput scale1(start=1,
        min=0,
        max=1,
        unit="1") "Shading of PV module" annotation (Placement(transformation(
            origin={-110,40},
            extent={{10,10},{-10,-10}},
            rotation=180), iconTransformation(
            extent={{-10,-10},{10,10}},
            rotation=0,
            origin={-110,20})));
      Modelica.Blocks.Interfaces.RealInput scale2(start=1,
        min=0,
        max=1,
        unit="1") "Shading of PV module" annotation (Placement(transformation(
            origin={-110,26},
            extent={{10,10},{-10,-10}},
            rotation=180), iconTransformation(
            extent={{-10,-10},{10,10}},
            rotation=0,
            origin={-110,0})));
      Modelica.Blocks.Interfaces.RealInput batt_ctrl3(start=0, unit="W")
        "Battery Power" annotation (Placement(transformation(
            origin={-110,-88},
            extent={{10,10},{-10,-10}},
            rotation=180), iconTransformation(
            extent={{-10,-10},{10,10}},
            rotation=0,
            origin={-110,-88})));
      Modelica.Blocks.Interfaces.RealInput batt_ctrl1(start=0, unit="W")
        "Battery Power" annotation (Placement(transformation(
            origin={-110,-60},
            extent={{10,10},{-10,-10}},
            rotation=180), iconTransformation(
            extent={{-10,-10},{10,10}},
            rotation=0,
            origin={-110,-50})));
      Modelica.Blocks.Interfaces.RealInput batt_ctrl2(start=0, unit="W")
        "Battery Power" annotation (Placement(transformation(
            origin={-110,-74},
            extent={{10,10},{-10,-10}},
            rotation=180), iconTransformation(
            extent={{-10,-10},{10,10}},
            rotation=0,
            origin={-110,-70})));
      Modelica.Blocks.Interfaces.RealInput pf2(start=1,
        min=0,
        max=1,
        unit="1") "Power Factor of Inverter" annotation (Placement(transformation(
            origin={26,-110},
            extent={{10,10},{-10,-10}},
            rotation=270), iconTransformation(
            extent={{-10,-10},{10,10}},
            rotation=90,
            origin={-10,-110})));
      Modelica.Blocks.Interfaces.RealInput pf3(
        start=1,
        min=0,
        max=1,
        unit="1") "Power Factor of Inverter" annotation (Placement(transformation(
            origin={40,-110},
            extent={{10,10},{-10,-10}},
            rotation=270), iconTransformation(
            extent={{-10,-10},{10,10}},
            rotation=90,
            origin={10,-110})));
      Modelica.Blocks.Interfaces.RealInput pf1(start=1,
        min=0,
        max=1,
        unit="1") "Power Factor of Inverter" annotation (Placement(transformation(
            origin={12,-110},
            extent={{10,10},{-10,-10}},
            rotation=270), iconTransformation(
            extent={{-10,-10},{10,10}},
            rotation=90,
            origin={-30,-110})));
      Modelica.Blocks.Interfaces.RealInput plim3(
        start=1,
        min=0,
        max=1,
        unit="1") "Power Limit of Inverter" annotation (Placement(transformation(
            origin={94,-110},
            extent={{10,10},{-10,-10}},
            rotation=270), iconTransformation(
            extent={{-10,-10},{10,10}},
            rotation=90,
            origin={90,-110})));
      Modelica.Blocks.Interfaces.RealInput plim2(
        start=1,
        min=0,
        max=1,
        unit="1") "Power Limit of Inverter" annotation (Placement(transformation(
            origin={80,-110},
            extent={{10,10},{-10,-10}},
            rotation=270), iconTransformation(
            extent={{-10,-10},{10,10}},
            rotation=90,
            origin={70,-110})));
      Modelica.Blocks.Interfaces.RealInput plim1(
        start=1,
        min=0,
        max=1,
        unit="1") "Power Limit of Inverter" annotation (Placement(transformation(
            origin={66,-110},
            extent={{10,10},{-10,-10}},
            rotation=270), iconTransformation(
            extent={{-10,-10},{10,10}},
            rotation=90,
            origin={50,-110})));
      Interfaces.FLEXGRID_interface interface
        annotation (Placement(transformation(extent={{-20,-30},{20,10}})));
      Components.uPMU.Model.uPMUSource_3ph source
        annotation (Placement(transformation(extent={{60,48},{40,68}})));
      Modelica.Blocks.Interfaces.RealInput V1(unit="V", start=120) "RMS voltage of the source" annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=180,
            origin={110,80}),  iconTransformation(
            extent={{-10,-10},{10,10}},
            rotation=180,
            origin={110,90})));
      Modelica.Blocks.Interfaces.RealInput f1(unit="Hz", start=60) "Frequency of the source" annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=180,
            origin={110,66}),  iconTransformation(
            extent={{-10,-10},{10,10}},
            rotation=180,
            origin={110,70})));
      Modelica.Blocks.Interfaces.RealInput V2(unit="V", start=120) "RMS voltage of the source" annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=180,
            origin={110,50}),  iconTransformation(
            extent={{-10,-10},{10,10}},
            rotation=180,
            origin={110,50})));
      Modelica.Blocks.Interfaces.RealInput f2(unit="Hz", start=60) "Frequency of the source" annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=180,
            origin={110,30}),  iconTransformation(
            extent={{-10,-10},{10,10}},
            rotation=180,
            origin={110,30})));
      Modelica.Blocks.Interfaces.RealInput V3(unit="V", start=120) "RMS voltage of the source" annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=180,
            origin={110,0}),   iconTransformation(
            extent={{-10,-10},{10,10}},
            rotation=180,
            origin={110,10})));
      Modelica.Blocks.Interfaces.RealInput f3(unit="Hz", start=60) "Frequency of the source" annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=180,
            origin={110,-10}), iconTransformation(
            extent={{-10,-10},{10,10}},
            rotation=180,
            origin={110,-10})));
    equation
      connect(weaDatInpCon1.weaBus, flexgrid.weaBus) annotation (Line(
          points={{-60,80},{-30,80},{-30,56},{-20,56}},
          color={255,204,51},
          thickness=0.5));
      connect(flexgrid.invCtrlBus1, interface.invCtrlBus1) annotation (Line(
          points={{-10,20},{-10,10}},
          color={255,204,51},
          thickness=0.5));
      connect(flexgrid.invCtrlBus2, interface.invCtrlBus2) annotation (Line(
          points={{0,20},{0,10}},
          color={255,204,51},
          thickness=0.5));
      connect(flexgrid.invCtrlBus3, interface.invCtrlBus3) annotation (Line(
          points={{10,20},{10,10}},
          color={255,204,51},
          thickness=0.5));
      connect(interface.batt_ctrl2, batt_ctrl2) annotation (Line(points={{-22,-24},
              {-80,-24},{-80,-74},{-110,-74}}, color={0,0,127}));
      connect(interface.batt_ctrl3, batt_ctrl3) annotation (Line(points={{-22,-28},
              {-76,-28},{-76,-88},{-110,-88}}, color={0,0,127}));
      connect(pf1, interface.pf1) annotation (Line(points={{12,-110},{12,-110},{12,
              -94},{-6,-94},{-6,-32}}, color={0,0,127}));
      connect(pf2, interface.pf2) annotation (Line(points={{26,-110},{26,-110},{26,
              -92},{-2,-92},{-2,-32}}, color={0,0,127}));
      connect(pf3, interface.pf3) annotation (Line(points={{40,-110},{40,-110},{40,
              -90},{2,-90},{2,-32}}, color={0,0,127}));
      connect(plim1, interface.plim1) annotation (Line(points={{66,-110},{66,-86},{
              10,-86},{10,-32}}, color={0,0,127}));
      connect(plim2, interface.plim2) annotation (Line(points={{80,-110},{80,-84},{
              14,-84},{14,-32}}, color={0,0,127}));
      connect(plim3, interface.plim3) annotation (Line(points={{94,-110},{94,-110},
              {94,-82},{18,-82},{18,-32}}, color={0,0,127}));
      connect(scale1, flexgrid.scale1) annotation (Line(points={{-110,40},{-84,40},
              {-84,44},{-22,44}}, color={0,0,127}));
      connect(scale2, flexgrid.scale2) annotation (Line(points={{-110,26},{-80,26},
              {-80,40},{-22,40}}, color={0,0,127}));
      connect(scale3, flexgrid.scale3) annotation (Line(points={{-110,12},{-76,12},
              {-76,36},{-22,36}}, color={0,0,127}));
      connect(batt_ctrl1, interface.batt_ctrl1) annotation (Line(points={{-110,-60},
              {-84,-60},{-84,-20},{-22,-20}}, color={0,0,127}));
      connect(flexgrid.terminal_p, source.terminal)
        annotation (Line(points={{22,58},{31,58},{40,58}}, color={0,120,120}));
      connect(V1, source.V1) annotation (Line(points={{110,80},{80,80},{80,67},{61,
              67}}, color={0,0,127}));
      connect(f1, source.f1)
        annotation (Line(points={{110,66},{61,66},{61,65}}, color={0,0,127}));
      connect(V2, source.V2) annotation (Line(points={{110,50},{86,50},{86,61},{61,
              61}}, color={0,0,127}));
      connect(f2, source.f2) annotation (Line(points={{110,30},{84,30},{84,59},{61,
              59}}, color={0,0,127}));
      connect(V3, source.V3) annotation (Line(points={{110,0},{82,0},{82,55},{61,55}},
            color={0,0,127}));
      connect(f3, source.f3) annotation (Line(points={{110,-10},{80,-10},{80,53},{
              61,53}}, color={0,0,127}));
      annotation (Icon(coordinateSystem(preserveAspectRatio=false)),
      experiment(StartTime=2.09952e+07, StopTime=2.22039e+07),
      Diagram(coordinateSystem(preserveAspectRatio=false)));
    end FLEXGRID_pf_FMU;

    model FLEXGRID_pvinput
      import SmartInverter = SCooDER;

      SmartInverter.Components.Transformer.Model.MPZ mpz_dist
        annotation (Placement(transformation(extent={{80,0},{60,20}})));
      SmartInverter.Components.Sensor.Model.Probe3ph sens_FLEXGRID(V_nominal=208)
        annotation (Placement(transformation(
            extent={{10,-10},{-10,10}},
            rotation=90,
            origin={90,40})));
      Modelica.Blocks.Interfaces.RealInput pv3(start=0,
        unit="W") "PV generation" annotation (Placement(transformation(
            origin={-110,12},
            extent={{10,10},{-10,-10}},
            rotation=180), iconTransformation(
            extent={{-10,-10},{10,10}},
            rotation=0,
            origin={-110,-20})));
      Modelica.Blocks.Interfaces.RealInput pv1(start=0,
        unit="W") "PV generation" annotation (Placement(transformation(
            origin={-110,40},
            extent={{10,10},{-10,-10}},
            rotation=180), iconTransformation(
            extent={{-10,-10},{10,10}},
            rotation=0,
            origin={-110,20})));
      Modelica.Blocks.Interfaces.RealInput pv2(start=0,
        unit="W") "PV generation" annotation (Placement(transformation(
            origin={-110,26},
            extent={{10,10},{-10,-10}},
            rotation=180), iconTransformation(
            extent={{-10,-10},{10,10}},
            rotation=0,
            origin={-110,0})));
      SmartInverter.Components.Battery.Model.Battery battery1
        annotation (Placement(transformation(extent={{-30,30},{-10,50}})));
      SmartInverter.Components.Battery.Model.Battery battery2
        annotation (Placement(transformation(extent={{-30,-10},{-10,10}})));
      SmartInverter.Components.Battery.Model.Battery battery3
        annotation (Placement(transformation(extent={{-30,-50},{-10,-30}})));
      Buildings.Electrical.AC.ThreePhasesUnbalanced.Lines.TwoPortMatrixRL FL_feed(
        Z12=20*(1.0/5280.0)*{0.0953,0.8515},
        Z13=20*(1.0/5280.0)*{0.0953,0.7266},
        Z23=20*(1.0/5280.0)*{0.0953,0.7802},
        V_nominal=208,
        Z11=20*(1.0/5280.0)*{0.4013,1.4133},
        Z22=20*(1.0/5280.0)*{0.4013,1.4133},
        Z33=20*(1.0/5280.0)*{0.4013,1.4133}) annotation (Placement(transformation(
            extent={{-10,10},{10,-10}},
            rotation=-90,
            origin={90,70})));

      Buildings.Electrical.AC.ThreePhasesUnbalanced.Interfaces.Terminal_p
                 terminal_p "Electric terminal side p"
        annotation (Placement(transformation(extent={{100,80},{120,100}}),
            iconTransformation(extent={{100,80},{120,100}})));
      SmartInverter.Components.Inverter.Model.Inverter inverter1
        annotation (Placement(transformation(extent={{26,40},{6,60}})));
      SmartInverter.Components.Inverter.Model.Inverter inverter2
        annotation (Placement(transformation(extent={{26,0},{6,20}})));
      SmartInverter.Components.Inverter.Model.Inverter inverter3
        annotation (Placement(transformation(extent={{26,-40},{6,-20}})));
      SmartInverter.Components.Inverter.Interfaces.InvCtrlBus
                                                         invCtrlBus1
                                                                    annotation (
          Placement(transformation(extent={{-60,-110},{-40,-90}}),
                                                                 iconTransformation(
              extent={{-60,-110},{-40,-90}})));
      SmartInverter.Components.Inverter.Interfaces.InvCtrlBus
                                                         invCtrlBus2
                                                                    annotation (
          Placement(transformation(extent={{-10,-110},{10,-90}}),iconTransformation(
              extent={{-10,-110},{10,-90}})));
      SmartInverter.Components.Inverter.Interfaces.InvCtrlBus
                                                         invCtrlBus3
                                                                    annotation (
          Placement(transformation(extent={{40,-110},{60,-90}}), iconTransformation(
              extent={{40,-110},{60,-90}})));
    equation
      connect(sens_FLEXGRID.terminal_p,mpz_dist. mpz_head)
        annotation (Line(points={{90,30},{90,10},{80,10}},
                                                   color={0,120,120}));
      connect(inverter1.term_p,mpz_dist. inv_1) annotation (Line(points={{26,50},{
              40,50},{40,16},{60,16}},
                                  color={0,120,120}));
      connect(mpz_dist.inv_2, inverter2.term_p)
        annotation (Line(points={{60,10},{26,10}},     color={0,120,120}));
      connect(mpz_dist.inv_3, inverter3.term_p) annotation (Line(points={{60,4},{40,
              4},{40,-30},{26,-30}}, color={0,120,120}));
      connect(inverter3.P_Batt, battery3.P_batt) annotation (Line(points={{4,-33},{
              -4,-33},{-4,-40},{-9,-40}}, color={0,0,127}));
      connect(inverter2.P_Batt, battery2.P_batt)
        annotation (Line(points={{4,7},{-4,7},{-4,0},{-9,0}}, color={0,0,127}));
      connect(inverter1.P_Batt, battery1.P_batt) annotation (Line(points={{4,47},{
              -4,47},{-4,40},{-9,40}}, color={0,0,127}));
      connect(FL_feed.terminal_p, sens_FLEXGRID.terminal_n)
        annotation (Line(points={{90,60},{90,50}}, color={0,120,120}));
      connect(FL_feed.terminal_n, terminal_p) annotation (Line(points={{90,80},{90,
              80},{90,90},{110,90}}, color={0,120,120}));
      connect(inverter3.batt_ctrl_inv, battery3.P_ctrl) annotation (Line(points={{5,
              -38},{0,-38},{0,-54},{-40,-54},{-40,-40},{-32,-40}}, color={0,0,127}));
      connect(inverter2.batt_ctrl_inv, battery2.P_ctrl) annotation (Line(points={{5,
              2},{0,2},{0,-14},{-40,-14},{-40,0},{-32,0}}, color={0,0,127}));
      connect(inverter1.batt_ctrl_inv, battery1.P_ctrl) annotation (Line(points={{5,
              42},{0,42},{0,26},{-40,26},{-40,40},{-32,40}}, color={0,0,127}));
      connect(invCtrlBus3, inverter3.invCtrlBus) annotation (Line(
          points={{50,-100},{50,-100},{50,-54},{16,-54},{16,-40}},
          color={255,204,51},
          thickness=0.5), Text(
          string="%first",
          index=-1,
          extent={{-6,3},{-6,3}}));
      connect(inverter2.invCtrlBus, invCtrlBus2) annotation (Line(
          points={{16,0},{16,0},{16,-14},{34,-14},{34,-86},{0,-86},{0,-100}},
          color={255,204,51},
          thickness=0.5), Text(
          string="%second",
          index=1,
          extent={{6,3},{6,3}}));
      connect(inverter1.invCtrlBus, invCtrlBus1) annotation (Line(
          points={{16,40},{16,40},{16,26},{32,26},{32,-84},{-50,-84},{-50,-100}},
          color={255,204,51},
          thickness=0.5), Text(
          string="%second",
          index=1,
          extent={{6,3},{6,3}}));
      connect(pv1, inverter1.P_PV) annotation (Line(points={{-110,40},{-60,40},{-60,
              56},{4,56}}, color={0,0,127}));
      connect(pv2, inverter2.P_PV) annotation (Line(points={{-110,26},{-60,26},{-60,
              16},{4,16}}, color={0,0,127}));
      connect(pv3, inverter3.P_PV) annotation (Line(points={{-110,12},{-60,12},{-60,
              -24},{4,-24}}, color={0,0,127}));
      annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
            coordinateSystem(preserveAspectRatio=false)));
    end FLEXGRID_pvinput;

    model FLEXGRID_pvinput_FMU

      FLEXGRID_pvinput
               flexgrid
        annotation (Placement(transformation(extent={{-20,20},{20,60}})));
      Modelica.Blocks.Interfaces.RealInput pv3(start=0,
        unit="W") "PV generation" annotation (Placement(transformation(
            origin={-110,12},
            extent={{10,10},{-10,-10}},
            rotation=180), iconTransformation(
            extent={{-10,-10},{10,10}},
            rotation=0,
            origin={-110,-20})));
      Modelica.Blocks.Interfaces.RealInput pv1(start=0,
        unit="W") "PV generation" annotation (Placement(transformation(
            origin={-110,40},
            extent={{10,10},{-10,-10}},
            rotation=180), iconTransformation(
            extent={{-10,-10},{10,10}},
            rotation=0,
            origin={-110,20})));
      Modelica.Blocks.Interfaces.RealInput pv2(start=0,
        unit="W") "PV generation" annotation (Placement(transformation(
            origin={-110,26},
            extent={{10,10},{-10,-10}},
            rotation=180), iconTransformation(
            extent={{-10,-10},{10,10}},
            rotation=0,
            origin={-110,0})));
      Modelica.Blocks.Interfaces.RealInput batt_ctrl3(start=0, unit="W")
        "Battery Power" annotation (Placement(transformation(
            origin={-110,-88},
            extent={{10,10},{-10,-10}},
            rotation=180), iconTransformation(
            extent={{-10,-10},{10,10}},
            rotation=0,
            origin={-110,-88})));
      Modelica.Blocks.Interfaces.RealInput batt_ctrl1(start=0, unit="W")
        "Battery Power" annotation (Placement(transformation(
            origin={-110,-60},
            extent={{10,10},{-10,-10}},
            rotation=180), iconTransformation(
            extent={{-10,-10},{10,10}},
            rotation=0,
            origin={-110,-50})));
      Modelica.Blocks.Interfaces.RealInput batt_ctrl2(start=0, unit="W")
        "Battery Power" annotation (Placement(transformation(
            origin={-110,-74},
            extent={{10,10},{-10,-10}},
            rotation=180), iconTransformation(
            extent={{-10,-10},{10,10}},
            rotation=0,
            origin={-110,-70})));
      Modelica.Blocks.Interfaces.RealInput q_ctrl1(start=0, unit="var") "Reactive power control of inverter." annotation (Placement(transformation(
            origin={12,-110},
            extent={{10,10},{-10,-10}},
            rotation=270), iconTransformation(
            extent={{-10,-10},{10,10}},
            rotation=90,
            origin={-30,-110})));
      Modelica.Blocks.Interfaces.RealInput q_ctrl2(start=0, unit="var") "Reactive power control of inverter." annotation (Placement(transformation(
            origin={26,-110},
            extent={{10,10},{-10,-10}},
            rotation=270), iconTransformation(
            extent={{-10,-10},{10,10}},
            rotation=90,
            origin={-10,-110})));
      Modelica.Blocks.Interfaces.RealInput q_ctrl3(start=0, unit="var") "Reactive power control of inverter." annotation (Placement(
            transformation(
            origin={40,-110},
            extent={{10,10},{-10,-10}},
            rotation=270), iconTransformation(
            extent={{-10,-10},{10,10}},
            rotation=90,
            origin={10,-110})));
      Modelica.Blocks.Interfaces.RealInput plim3(
        start=1,
        min=0,
        max=1,
        unit="1") "Power Limit of Inverter" annotation (Placement(transformation(
            origin={94,-110},
            extent={{10,10},{-10,-10}},
            rotation=270), iconTransformation(
            extent={{-10,-10},{10,10}},
            rotation=90,
            origin={90,-110})));
      Modelica.Blocks.Interfaces.RealInput plim2(
        start=1,
        min=0,
        max=1,
        unit="1") "Power Limit of Inverter" annotation (Placement(transformation(
            origin={80,-110},
            extent={{10,10},{-10,-10}},
            rotation=270), iconTransformation(
            extent={{-10,-10},{10,10}},
            rotation=90,
            origin={70,-110})));
      Modelica.Blocks.Interfaces.RealInput plim1(
        start=1,
        min=0,
        max=1,
        unit="1") "Power Limit of Inverter" annotation (Placement(transformation(
            origin={66,-110},
            extent={{10,10},{-10,-10}},
            rotation=270), iconTransformation(
            extent={{-10,-10},{10,10}},
            rotation=90,
            origin={50,-110})));
      Interfaces.FLEXGRID_interface interface
        annotation (Placement(transformation(extent={{-20,-30},{20,10}})));
      Components.uPMU.Model.uPMUSource_3ph source
        annotation (Placement(transformation(extent={{60,48},{40,68}})));
      Modelica.Blocks.Interfaces.RealInput V1(unit="V", start=120) "RMS voltage of the source" annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=180,
            origin={110,80}),  iconTransformation(
            extent={{-10,-10},{10,10}},
            rotation=180,
            origin={110,90})));
      Modelica.Blocks.Interfaces.RealInput f1(unit="Hz", start=60) "Frequency of the source" annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=180,
            origin={110,66}),  iconTransformation(
            extent={{-10,-10},{10,10}},
            rotation=180,
            origin={110,70})));
      Modelica.Blocks.Interfaces.RealInput V2(unit="V", start=120) "RMS voltage of the source" annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=180,
            origin={110,50}),  iconTransformation(
            extent={{-10,-10},{10,10}},
            rotation=180,
            origin={110,50})));
      Modelica.Blocks.Interfaces.RealInput f2(unit="Hz", start=60) "Frequency of the source" annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=180,
            origin={110,30}),  iconTransformation(
            extent={{-10,-10},{10,10}},
            rotation=180,
            origin={110,30})));
      Modelica.Blocks.Interfaces.RealInput V3(unit="V", start=120) "RMS voltage of the source" annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=180,
            origin={110,0}),   iconTransformation(
            extent={{-10,-10},{10,10}},
            rotation=180,
            origin={110,10})));
      Modelica.Blocks.Interfaces.RealInput f3(unit="Hz", start=60) "Frequency of the source" annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=180,
            origin={110,-10}), iconTransformation(
            extent={{-10,-10},{10,10}},
            rotation=180,
            origin={110,-10})));
      Modelica.Blocks.Continuous.FirstOrder firstOrder(T=0.001, initType=Modelica.Blocks.Types.Init.InitialState)
        annotation (Placement(transformation(extent={{-96,36},{-88,44}})));
      Modelica.Blocks.Continuous.FirstOrder firstOrder1(T=0.001, initType=Modelica.Blocks.Types.Init.InitialState)
        annotation (Placement(transformation(extent={{-96,22},{-88,30}})));
      Modelica.Blocks.Continuous.FirstOrder firstOrder2(T=0.001, initType=Modelica.Blocks.Types.Init.InitialState)
        annotation (Placement(transformation(extent={{-96,8},{-88,16}})));
    equation
      connect(flexgrid.invCtrlBus1, interface.invCtrlBus1) annotation (Line(
          points={{-10,20},{-10,10}},
          color={255,204,51},
          thickness=0.5));
      connect(flexgrid.invCtrlBus2, interface.invCtrlBus2) annotation (Line(
          points={{0,20},{0,10}},
          color={255,204,51},
          thickness=0.5));
      connect(flexgrid.invCtrlBus3, interface.invCtrlBus3) annotation (Line(
          points={{10,20},{10,10}},
          color={255,204,51},
          thickness=0.5));
      connect(interface.batt_ctrl2, batt_ctrl2) annotation (Line(points={{-22,-24},
              {-80,-24},{-80,-74},{-110,-74}}, color={0,0,127}));
      connect(interface.batt_ctrl3, batt_ctrl3) annotation (Line(points={{-22,-28},
              {-76,-28},{-76,-88},{-110,-88}}, color={0,0,127}));
      connect(plim1, interface.plim1) annotation (Line(points={{66,-110},{66,-86},{
              10,-86},{10,-32}}, color={0,0,127}));
      connect(plim2, interface.plim2) annotation (Line(points={{80,-110},{80,-84},{
              14,-84},{14,-32}}, color={0,0,127}));
      connect(plim3, interface.plim3) annotation (Line(points={{94,-110},{94,-110},
              {94,-82},{18,-82},{18,-32}}, color={0,0,127}));
      connect(batt_ctrl1, interface.batt_ctrl1) annotation (Line(points={{-110,-60},
              {-84,-60},{-84,-20},{-22,-20}}, color={0,0,127}));
      connect(flexgrid.terminal_p, source.terminal)
        annotation (Line(points={{22,58},{31,58},{40,58}}, color={0,120,120}));
      connect(V1, source.V1) annotation (Line(points={{110,80},{80,80},{80,67},{61,
              67}}, color={0,0,127}));
      connect(f1, source.f1)
        annotation (Line(points={{110,66},{61,66},{61,65}}, color={0,0,127}));
      connect(V2, source.V2) annotation (Line(points={{110,50},{86,50},{86,61},{61,
              61}}, color={0,0,127}));
      connect(f2, source.f2) annotation (Line(points={{110,30},{84,30},{84,59},{61,
              59}}, color={0,0,127}));
      connect(V3, source.V3) annotation (Line(points={{110,0},{82,0},{82,55},{61,55}},
            color={0,0,127}));
      connect(f3, source.f3) annotation (Line(points={{110,-10},{80,-10},{80,53},{
              61,53}}, color={0,0,127}));
      connect(interface.q_ctrl1, q_ctrl1) annotation (Line(points={{-6,-32},{-6,-32},
              {-6,-94},{12,-94},{12,-110},{12,-110}}, color={0,0,127}));
      connect(interface.q_ctrl2, q_ctrl2) annotation (Line(points={{-2,-32},{-2,-32},
              {-2,-92},{26,-92},{26,-110},{26,-110}}, color={0,0,127}));
      connect(interface.q_ctrl3, q_ctrl3) annotation (Line(points={{2,-32},{2,-32},
              {2,-34},{2,-34},{2,-90},{40,-90},{40,-110},{40,-110}}, color={0,0,127}));
      connect(pv1, firstOrder.u)
        annotation (Line(points={{-110,40},{-96.8,40}}, color={0,0,127}));
      connect(firstOrder.y, flexgrid.pv1) annotation (Line(points={{-87.6,40},{-80,
              40},{-80,44},{-22,44}}, color={0,0,127}));
      connect(pv2, firstOrder1.u)
        annotation (Line(points={{-110,26},{-96.8,26}}, color={0,0,127}));
      connect(firstOrder1.y, flexgrid.pv2) annotation (Line(points={{-87.6,26},{-66,
              26},{-66,40},{-22,40}}, color={0,0,127}));
      connect(pv3, firstOrder2.u)
        annotation (Line(points={{-110,12},{-96.8,12}}, color={0,0,127}));
      connect(firstOrder2.y, flexgrid.pv3) annotation (Line(points={{-87.6,12},{-60,
              12},{-60,36},{-22,36}}, color={0,0,127}));
      annotation (Icon(coordinateSystem(preserveAspectRatio=false)),
      experiment(StartTime=2.09952e+07, StopTime=2.22039e+07),
      Diagram(coordinateSystem(preserveAspectRatio=false)));
    end FLEXGRID_pvinput_FMU;

    model FLEXGRID_direct_wye
      import SmartInverter = SCooDER;

      SmartInverter.Components.Sensor.Model.Probe3ph sens_FLEXGRID(V_nominal=208)
        annotation (Placement(transformation(
            extent={{10,-10},{-10,10}},
            rotation=90,
            origin={90,40})));
      Modelica.Blocks.Interfaces.RealInput scale3(start=1,
        min=0,
        max=1,
        unit="1") "Shading of PV module" annotation (Placement(transformation(
            origin={-110,12},
            extent={{10,10},{-10,-10}},
            rotation=180), iconTransformation(
            extent={{-10,-10},{10,10}},
            rotation=0,
            origin={-110,-20})));
      Modelica.Blocks.Interfaces.RealInput scale1(start=1,
        min=0,
        max=1,
        unit="1") "Shading of PV module" annotation (Placement(transformation(
            origin={-110,40},
            extent={{10,10},{-10,-10}},
            rotation=180), iconTransformation(
            extent={{-10,-10},{10,10}},
            rotation=0,
            origin={-110,20})));
      Modelica.Blocks.Interfaces.RealInput scale2(start=1,
        min=0,
        max=1,
        unit="1") "Shading of PV module" annotation (Placement(transformation(
            origin={-110,26},
            extent={{10,10},{-10,-10}},
            rotation=180), iconTransformation(
            extent={{-10,-10},{10,10}},
            rotation=0,
            origin={-110,0})));
      SmartInverter.Components.Battery.Model.Battery battery1
        annotation (Placement(transformation(extent={{-30,30},{-10,50}})));
      SmartInverter.Components.Battery.Model.Battery battery2
        annotation (Placement(transformation(extent={{-30,-10},{-10,10}})));
      SmartInverter.Components.Battery.Model.Battery battery3
        annotation (Placement(transformation(extent={{-30,-50},{-10,-30}})));
      SmartInverter.Components.Photovoltaics.Model.PVModule_simple pv1
        annotation (Placement(transformation(extent={{-64,46},{-44,66}})));
      SmartInverter.Components.Photovoltaics.Model.PVModule_simple pv2(n=28)
        annotation (Placement(transformation(extent={{-64,6},{-44,26}})));
      SmartInverter.Components.Photovoltaics.Model.PVModule_simple pv3
        annotation (Placement(transformation(extent={{-64,-34},{-44,-14}})));
      Buildings.BoundaryConditions.WeatherData.Bus
                      weaBus "Bus with weather data"
        annotation (Placement(transformation(extent={{-110,70},{-90,90}})));
      Buildings.Electrical.AC.ThreePhasesUnbalanced.Lines.TwoPortMatrixRL FL_feed(
        Z12=20*(1.0/5280.0)*{0.0953,0.8515},
        Z13=20*(1.0/5280.0)*{0.0953,0.7266},
        Z23=20*(1.0/5280.0)*{0.0953,0.7802},
        V_nominal=208,
        Z11=20*(1.0/5280.0)*{0.4013,1.4133},
        Z22=20*(1.0/5280.0)*{0.4013,1.4133},
        Z33=20*(1.0/5280.0)*{0.4013,1.4133}) annotation (Placement(transformation(
            extent={{-10,10},{10,-10}},
            rotation=-90,
            origin={90,70})));

      Buildings.Electrical.AC.ThreePhasesUnbalanced.Interfaces.Terminal_p
                 terminal_p "Electric terminal side p"
        annotation (Placement(transformation(extent={{100,80},{120,100}}),
            iconTransformation(extent={{100,80},{120,100}})));
      SmartInverter.Components.Inverter.Model.Inverter inverter1
        annotation (Placement(transformation(extent={{26,40},{6,60}})));
      SmartInverter.Components.Inverter.Model.Inverter inverter2
        annotation (Placement(transformation(extent={{26,0},{6,20}})));
      SmartInverter.Components.Inverter.Model.Inverter inverter3
        annotation (Placement(transformation(extent={{26,-40},{6,-20}})));
      SmartInverter.Components.Inverter.Interfaces.InvCtrlBus
                                                         invCtrlBus1
                                                                    annotation (
          Placement(transformation(extent={{-60,-110},{-40,-90}}),
                                                                 iconTransformation(
              extent={{-60,-110},{-40,-90}})));
      SmartInverter.Components.Inverter.Interfaces.InvCtrlBus
                                                         invCtrlBus2
                                                                    annotation (
          Placement(transformation(extent={{-10,-110},{10,-90}}),iconTransformation(
              extent={{-10,-110},{10,-90}})));
      SmartInverter.Components.Inverter.Interfaces.InvCtrlBus
                                                         invCtrlBus3
                                                                    annotation (
          Placement(transformation(extent={{40,-110},{60,-90}}), iconTransformation(
              extent={{40,-110},{60,-90}})));
      Buildings.Electrical.AC.ThreePhasesUnbalanced.Interfaces.Adapter3to3 wye
        annotation (Placement(transformation(extent={{60,0},{80,20}})));
    equation
      connect(inverter2.P_PV, pv2.P)
        annotation (Line(points={{4,16},{-20,16},{-43,16}},
                                                 color={0,0,127}));
      connect(inverter3.P_PV, pv3.P)
        annotation (Line(points={{4,-24},{-20,-24},{-43,-24}},
                                                     color={0,0,127}));
      connect(inverter1.P_PV, pv1.P)
        annotation (Line(points={{4,56},{-20,56},{-43,56}},
                                                   color={0,0,127}));
      connect(inverter3.P_Batt, battery3.P_batt) annotation (Line(points={{4,-33},{
              -4,-33},{-4,-40},{-9,-40}}, color={0,0,127}));
      connect(inverter2.P_Batt, battery2.P_batt)
        annotation (Line(points={{4,7},{-4,7},{-4,0},{-9,0}}, color={0,0,127}));
      connect(inverter1.P_Batt, battery1.P_batt) annotation (Line(points={{4,47},{
              -4,47},{-4,40},{-9,40}}, color={0,0,127}));
      connect(scale1, pv1.scale)
        annotation (Line(points={{-110,40},{-66,40},{-66,52}}, color={0,0,127}));
      connect(scale2, pv2.scale) annotation (Line(points={{-110,26},{-92,26},{-92,
              12},{-66,12}},
                        color={0,0,127}));
      connect(scale3, pv3.scale) annotation (Line(points={{-110,12},{-94,12},{-94,
              -28},{-66,-28}},
                          color={0,0,127}));
      connect(pv1.weaBus, weaBus) annotation (Line(
          points={{-64,60},{-80,60},{-80,80},{-100,80}},
          color={255,204,51},
          thickness=0.5), Text(
          string="%second",
          index=1,
          extent={{6,3},{6,3}}));
      connect(pv2.weaBus, weaBus) annotation (Line(
          points={{-64,20},{-80,20},{-80,80},{-100,80}},
          color={255,204,51},
          thickness=0.5), Text(
          string="%second",
          index=1,
          extent={{6,3},{6,3}}));
      connect(pv3.weaBus, weaBus) annotation (Line(
          points={{-64,-20},{-80,-20},{-80,80},{-100,80}},
          color={255,204,51},
          thickness=0.5), Text(
          string="%second",
          index=1,
          extent={{6,3},{6,3}}));
      connect(FL_feed.terminal_p, sens_FLEXGRID.terminal_n)
        annotation (Line(points={{90,60},{90,50}}, color={0,120,120}));
      connect(FL_feed.terminal_n, terminal_p) annotation (Line(points={{90,80},{90,
              80},{90,90},{110,90}}, color={0,120,120}));
      connect(inverter3.batt_ctrl_inv, battery3.P_ctrl) annotation (Line(points={{5,
              -38},{0,-38},{0,-54},{-40,-54},{-40,-40},{-32,-40}}, color={0,0,127}));
      connect(inverter2.batt_ctrl_inv, battery2.P_ctrl) annotation (Line(points={{5,
              2},{0,2},{0,-14},{-40,-14},{-40,0},{-32,0}}, color={0,0,127}));
      connect(inverter1.batt_ctrl_inv, battery1.P_ctrl) annotation (Line(points={{5,
              42},{0,42},{0,26},{-40,26},{-40,40},{-32,40}}, color={0,0,127}));
      connect(invCtrlBus3, inverter3.invCtrlBus) annotation (Line(
          points={{50,-100},{50,-100},{50,-54},{16,-54},{16,-40}},
          color={255,204,51},
          thickness=0.5), Text(
          string="%first",
          index=-1,
          extent={{-6,3},{-6,3}}));
      connect(inverter2.invCtrlBus, invCtrlBus2) annotation (Line(
          points={{16,0},{16,0},{16,-14},{34,-14},{34,-86},{0,-86},{0,-100}},
          color={255,204,51},
          thickness=0.5), Text(
          string="%second",
          index=1,
          extent={{6,3},{6,3}}));
      connect(inverter1.invCtrlBus, invCtrlBus1) annotation (Line(
          points={{16,40},{16,40},{16,26},{32,26},{32,-84},{-50,-84},{-50,-100}},
          color={255,204,51},
          thickness=0.5), Text(
          string="%second",
          index=1,
          extent={{6,3},{6,3}}));
      connect(sens_FLEXGRID.terminal_p, wye.terminal) annotation (Line(points={{90,
              30},{90,30},{90,10},{80,10}}, color={0,120,120}));
      connect(inverter1.term_p, wye.terminals[1]) annotation (Line(points={{26,50},
              {38,50},{38,50},{50,50},{50,10.5333},{60.2,10.5333}}, color={0,120,
              120}));
      connect(inverter2.term_p, wye.terminals[2])
        annotation (Line(points={{26,10},{60.2,10},{60.2,10}}, color={0,120,120}));
      connect(inverter3.term_p, wye.terminals[3]) annotation (Line(points={{26,-30},
              {50,-30},{50,9.46667},{60.2,9.46667}}, color={0,120,120}));
      annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
            coordinateSystem(preserveAspectRatio=false)));
    end FLEXGRID_direct_wye;

    model FLEXGRID_direct_wye_FMU

      FLEXGRID_direct_wye
               flexgrid
        annotation (Placement(transformation(extent={{-20,20},{20,60}})));
      Buildings.BoundaryConditions.WeatherData.ReaderTMY3 weaDatInpCon1(
        computeWetBulbTemperature=false, filNam="C:/Users/Christoph/Documents/SmartInverter/smartinverter_simulation/ExampleData/USA_CA_San.Francisco.Intl.AP.724940_TMY3_CONVERTED.mos")
        "Weather data reader with radiation data obtained from the inputs' connectors"
        annotation (Placement(transformation(extent={{-80,70},{-60,90}})));
      Modelica.Blocks.Interfaces.RealInput scale3(start=1,
        min=0,
        max=1,
        unit="1") "Shading of PV module" annotation (Placement(transformation(
            origin={-110,12},
            extent={{10,10},{-10,-10}},
            rotation=180), iconTransformation(
            extent={{-10,-10},{10,10}},
            rotation=0,
            origin={-110,-20})));
      Modelica.Blocks.Interfaces.RealInput scale1(start=1,
        min=0,
        max=1,
        unit="1") "Shading of PV module" annotation (Placement(transformation(
            origin={-110,40},
            extent={{10,10},{-10,-10}},
            rotation=180), iconTransformation(
            extent={{-10,-10},{10,10}},
            rotation=0,
            origin={-110,20})));
      Modelica.Blocks.Interfaces.RealInput scale2(start=1,
        min=0,
        max=1,
        unit="1") "Shading of PV module" annotation (Placement(transformation(
            origin={-110,26},
            extent={{10,10},{-10,-10}},
            rotation=180), iconTransformation(
            extent={{-10,-10},{10,10}},
            rotation=0,
            origin={-110,0})));
      Modelica.Blocks.Interfaces.RealInput batt_ctrl3(start=0, unit="W")
        "Battery Power" annotation (Placement(transformation(
            origin={-110,-88},
            extent={{10,10},{-10,-10}},
            rotation=180), iconTransformation(
            extent={{-10,-10},{10,10}},
            rotation=0,
            origin={-110,-88})));
      Modelica.Blocks.Interfaces.RealInput batt_ctrl1(start=0, unit="W")
        "Battery Power" annotation (Placement(transformation(
            origin={-110,-60},
            extent={{10,10},{-10,-10}},
            rotation=180), iconTransformation(
            extent={{-10,-10},{10,10}},
            rotation=0,
            origin={-110,-50})));
      Modelica.Blocks.Interfaces.RealInput batt_ctrl2(start=0, unit="W")
        "Battery Power" annotation (Placement(transformation(
            origin={-110,-74},
            extent={{10,10},{-10,-10}},
            rotation=180), iconTransformation(
            extent={{-10,-10},{10,10}},
            rotation=0,
            origin={-110,-70})));
      Modelica.Blocks.Interfaces.RealInput q_ctrl1(start=0, unit="var") "Reactive power control of inverter." annotation (Placement(transformation(
            origin={12,-110},
            extent={{10,10},{-10,-10}},
            rotation=270), iconTransformation(
            extent={{-10,-10},{10,10}},
            rotation=90,
            origin={-30,-110})));
      Modelica.Blocks.Interfaces.RealInput q_ctrl2(start=0, unit="var") "Reactive power control of inverter." annotation (Placement(transformation(
            origin={26,-110},
            extent={{10,10},{-10,-10}},
            rotation=270), iconTransformation(
            extent={{-10,-10},{10,10}},
            rotation=90,
            origin={-10,-110})));
      Modelica.Blocks.Interfaces.RealInput q_ctrl3(start=0, unit="var") "Reactive power control of inverter." annotation (Placement(
            transformation(
            origin={40,-110},
            extent={{10,10},{-10,-10}},
            rotation=270), iconTransformation(
            extent={{-10,-10},{10,10}},
            rotation=90,
            origin={10,-110})));
      Modelica.Blocks.Interfaces.RealInput plim3(
        start=1,
        min=0,
        max=1,
        unit="1") "Power Limit of Inverter" annotation (Placement(transformation(
            origin={94,-110},
            extent={{10,10},{-10,-10}},
            rotation=270), iconTransformation(
            extent={{-10,-10},{10,10}},
            rotation=90,
            origin={90,-110})));
      Modelica.Blocks.Interfaces.RealInput plim2(
        start=1,
        min=0,
        max=1,
        unit="1") "Power Limit of Inverter" annotation (Placement(transformation(
            origin={80,-110},
            extent={{10,10},{-10,-10}},
            rotation=270), iconTransformation(
            extent={{-10,-10},{10,10}},
            rotation=90,
            origin={70,-110})));
      Modelica.Blocks.Interfaces.RealInput plim1(
        start=1,
        min=0,
        max=1,
        unit="1") "Power Limit of Inverter" annotation (Placement(transformation(
            origin={66,-110},
            extent={{10,10},{-10,-10}},
            rotation=270), iconTransformation(
            extent={{-10,-10},{10,10}},
            rotation=90,
            origin={50,-110})));
      Interfaces.FLEXGRID_interface interface
        annotation (Placement(transformation(extent={{-20,-30},{20,10}})));
      Components.uPMU.Model.uPMUSource_3ph source
        annotation (Placement(transformation(extent={{60,48},{40,68}})));
      Modelica.Blocks.Interfaces.RealInput V1(unit="V", start=120) "RMS voltage of the source" annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=180,
            origin={110,80}),  iconTransformation(
            extent={{-10,-10},{10,10}},
            rotation=180,
            origin={110,90})));
      Modelica.Blocks.Interfaces.RealInput f1(unit="Hz", start=60) "Frequency of the source" annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=180,
            origin={110,66}),  iconTransformation(
            extent={{-10,-10},{10,10}},
            rotation=180,
            origin={110,70})));
      Modelica.Blocks.Interfaces.RealInput V2(unit="V", start=120) "RMS voltage of the source" annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=180,
            origin={110,50}),  iconTransformation(
            extent={{-10,-10},{10,10}},
            rotation=180,
            origin={110,50})));
      Modelica.Blocks.Interfaces.RealInput f2(unit="Hz", start=60) "Frequency of the source" annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=180,
            origin={110,30}),  iconTransformation(
            extent={{-10,-10},{10,10}},
            rotation=180,
            origin={110,30})));
      Modelica.Blocks.Interfaces.RealInput V3(unit="V", start=120) "RMS voltage of the source" annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=180,
            origin={110,0}),   iconTransformation(
            extent={{-10,-10},{10,10}},
            rotation=180,
            origin={110,10})));
      Modelica.Blocks.Interfaces.RealInput f3(unit="Hz", start=60) "Frequency of the source" annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=180,
            origin={110,-10}), iconTransformation(
            extent={{-10,-10},{10,10}},
            rotation=180,
            origin={110,-10})));
    equation
      connect(weaDatInpCon1.weaBus, flexgrid.weaBus) annotation (Line(
          points={{-60,80},{-30,80},{-30,56},{-20,56}},
          color={255,204,51},
          thickness=0.5));
      connect(flexgrid.invCtrlBus1, interface.invCtrlBus1) annotation (Line(
          points={{-10,20},{-10,10}},
          color={255,204,51},
          thickness=0.5));
      connect(flexgrid.invCtrlBus2, interface.invCtrlBus2) annotation (Line(
          points={{0,20},{0,10}},
          color={255,204,51},
          thickness=0.5));
      connect(flexgrid.invCtrlBus3, interface.invCtrlBus3) annotation (Line(
          points={{10,20},{10,10}},
          color={255,204,51},
          thickness=0.5));
      connect(interface.batt_ctrl2, batt_ctrl2) annotation (Line(points={{-22,-24},
              {-80,-24},{-80,-74},{-110,-74}}, color={0,0,127}));
      connect(interface.batt_ctrl3, batt_ctrl3) annotation (Line(points={{-22,-28},
              {-76,-28},{-76,-88},{-110,-88}}, color={0,0,127}));
      connect(plim1, interface.plim1) annotation (Line(points={{66,-110},{66,-86},{
              10,-86},{10,-32}}, color={0,0,127}));
      connect(plim2, interface.plim2) annotation (Line(points={{80,-110},{80,-84},{
              14,-84},{14,-32}}, color={0,0,127}));
      connect(plim3, interface.plim3) annotation (Line(points={{94,-110},{94,-110},
              {94,-82},{18,-82},{18,-32}}, color={0,0,127}));
      connect(scale1, flexgrid.scale1) annotation (Line(points={{-110,40},{-84,40},
              {-84,44},{-22,44}}, color={0,0,127}));
      connect(scale2, flexgrid.scale2) annotation (Line(points={{-110,26},{-80,26},
              {-80,40},{-22,40}}, color={0,0,127}));
      connect(scale3, flexgrid.scale3) annotation (Line(points={{-110,12},{-76,12},
              {-76,36},{-22,36}}, color={0,0,127}));
      connect(batt_ctrl1, interface.batt_ctrl1) annotation (Line(points={{-110,-60},
              {-84,-60},{-84,-20},{-22,-20}}, color={0,0,127}));
      connect(flexgrid.terminal_p, source.terminal)
        annotation (Line(points={{22,58},{31,58},{40,58}}, color={0,120,120}));
      connect(V1, source.V1) annotation (Line(points={{110,80},{80,80},{80,67},{61,
              67}}, color={0,0,127}));
      connect(f1, source.f1)
        annotation (Line(points={{110,66},{61,66},{61,65}}, color={0,0,127}));
      connect(V2, source.V2) annotation (Line(points={{110,50},{86,50},{86,61},{61,
              61}}, color={0,0,127}));
      connect(f2, source.f2) annotation (Line(points={{110,30},{84,30},{84,59},{61,
              59}}, color={0,0,127}));
      connect(V3, source.V3) annotation (Line(points={{110,0},{82,0},{82,55},{61,55}},
            color={0,0,127}));
      connect(f3, source.f3) annotation (Line(points={{110,-10},{80,-10},{80,53},{
              61,53}}, color={0,0,127}));
      connect(interface.q_ctrl1, q_ctrl1) annotation (Line(points={{-6,-32},{-6,-32},
              {-6,-94},{12,-94},{12,-110}},           color={0,0,127}));
      connect(interface.q_ctrl2, q_ctrl2) annotation (Line(points={{-2,-32},{-2,-32},
              {-2,-92},{26,-92},{26,-110}},           color={0,0,127}));
      connect(interface.q_ctrl3, q_ctrl3) annotation (Line(points={{2,-32},{2,-32},
              {2,-34},{2,-90},{40,-90},{40,-110}},                   color={0,0,127}));
      annotation (Icon(coordinateSystem(preserveAspectRatio=false)),
      experiment(StartTime=2.09952e+07, StopTime=2.22039e+07),
      Diagram(coordinateSystem(preserveAspectRatio=false)));
    end FLEXGRID_direct_wye_FMU;

    model FLEXGRID_direct_wye_voltvar_FMU
      parameter Real V_nominal(min=0, unit="V") = 240 "Nominal sytem voltage to scale Vp.u.";
      parameter Real v_max( start=1.05, unit="1")=1.05 "Voltage maximum [p.u.]";
      parameter Real v_maxdead( start=1.01, unit="1")=1.01 "Upper bound of deadband [p.u.]";
      parameter Real v_mindead( start=0.99, unit="1")=0.99 "Upper bound of deadband [p.u.]";
      parameter Real v_min( start=0.95, unit="1")=0.95 "Voltage minimum [p.u.]";
      parameter Real q_maxind( start=1000, unit="var")=2500 "Maximal Reactive Power (Inductive) [var]";
      parameter Real q_maxcap( start=1000, unit="var")=2500 "Maximal Reactive Power (Capacitive) [var]";

      FLEXGRID_direct_wye
               flexgrid
        annotation (Placement(transformation(extent={{-20,20},{20,60}})));
      Buildings.BoundaryConditions.WeatherData.ReaderTMY3 weaDatInpCon1(
        computeWetBulbTemperature=false, filNam="C:/Users/Christoph/Documents/SmartInverter/smartinverter_simulation/ExampleData/USA_CA_San.Francisco.Intl.AP.724940_TMY3_CONVERTED.mos")
        "Weather data reader with radiation data obtained from the inputs' connectors"
        annotation (Placement(transformation(extent={{-80,70},{-60,90}})));
      Modelica.Blocks.Interfaces.RealInput scale3(start=1,
        min=0,
        max=1,
        unit="1") "Shading of PV module" annotation (Placement(transformation(
            origin={-110,12},
            extent={{10,10},{-10,-10}},
            rotation=180), iconTransformation(
            extent={{-10,-10},{10,10}},
            rotation=0,
            origin={-110,-20})));
      Modelica.Blocks.Interfaces.RealInput scale1(start=1,
        min=0,
        max=1,
        unit="1") "Shading of PV module" annotation (Placement(transformation(
            origin={-110,40},
            extent={{10,10},{-10,-10}},
            rotation=180), iconTransformation(
            extent={{-10,-10},{10,10}},
            rotation=0,
            origin={-110,20})));
      Modelica.Blocks.Interfaces.RealInput scale2(start=1,
        min=0,
        max=1,
        unit="1") "Shading of PV module" annotation (Placement(transformation(
            origin={-110,26},
            extent={{10,10},{-10,-10}},
            rotation=180), iconTransformation(
            extent={{-10,-10},{10,10}},
            rotation=0,
            origin={-110,0})));
      Modelica.Blocks.Interfaces.RealInput batt_ctrl3(start=0, unit="W")
        "Battery Power" annotation (Placement(transformation(
            origin={-110,-88},
            extent={{10,10},{-10,-10}},
            rotation=180), iconTransformation(
            extent={{-10,-10},{10,10}},
            rotation=0,
            origin={-110,-88})));
      Modelica.Blocks.Interfaces.RealInput batt_ctrl1(start=0, unit="W")
        "Battery Power" annotation (Placement(transformation(
            origin={-110,-60},
            extent={{10,10},{-10,-10}},
            rotation=180), iconTransformation(
            extent={{-10,-10},{10,10}},
            rotation=0,
            origin={-110,-50})));
      Modelica.Blocks.Interfaces.RealInput batt_ctrl2(start=0, unit="W")
        "Battery Power" annotation (Placement(transformation(
            origin={-110,-74},
            extent={{10,10},{-10,-10}},
            rotation=180), iconTransformation(
            extent={{-10,-10},{10,10}},
            rotation=0,
            origin={-110,-70})));
      Modelica.Blocks.Interfaces.RealInput plim3(
        start=1,
        min=0,
        max=1,
        unit="1") "Power Limit of Inverter" annotation (Placement(transformation(
            origin={94,-110},
            extent={{10,10},{-10,-10}},
            rotation=270), iconTransformation(
            extent={{-10,-10},{10,10}},
            rotation=90,
            origin={90,-110})));
      Modelica.Blocks.Interfaces.RealInput plim2(
        start=1,
        min=0,
        max=1,
        unit="1") "Power Limit of Inverter" annotation (Placement(transformation(
            origin={80,-110},
            extent={{10,10},{-10,-10}},
            rotation=270), iconTransformation(
            extent={{-10,-10},{10,10}},
            rotation=90,
            origin={70,-110})));
      Modelica.Blocks.Interfaces.RealInput plim1(
        start=1,
        min=0,
        max=1,
        unit="1") "Power Limit of Inverter" annotation (Placement(transformation(
            origin={66,-110},
            extent={{10,10},{-10,-10}},
            rotation=270), iconTransformation(
            extent={{-10,-10},{10,10}},
            rotation=90,
            origin={50,-110})));
      Interfaces.FLEXGRID_interface_voltvar interface(
        V_nominal=V_nominal,
        v_max=v_max,
        v_maxdead=v_maxdead,
        v_mindead=v_mindead,
        v_min=v_min,
        q_maxind=q_maxind,
        q_maxcap=q_maxcap)
        annotation (Placement(transformation(extent={{-20,-30},{20,10}})));
      Components.uPMU.Model.uPMUSource_3ph source
        annotation (Placement(transformation(extent={{60,48},{40,68}})));
      Modelica.Blocks.Interfaces.RealInput V1(unit="V", start=120) "RMS voltage of the source" annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=180,
            origin={110,80}),  iconTransformation(
            extent={{-10,-10},{10,10}},
            rotation=180,
            origin={110,90})));
      Modelica.Blocks.Interfaces.RealInput f1(unit="Hz", start=60) "Frequency of the source" annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=180,
            origin={110,66}),  iconTransformation(
            extent={{-10,-10},{10,10}},
            rotation=180,
            origin={110,70})));
      Modelica.Blocks.Interfaces.RealInput V2(unit="V", start=120) "RMS voltage of the source" annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=180,
            origin={110,50}),  iconTransformation(
            extent={{-10,-10},{10,10}},
            rotation=180,
            origin={110,50})));
      Modelica.Blocks.Interfaces.RealInput f2(unit="Hz", start=60) "Frequency of the source" annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=180,
            origin={110,30}),  iconTransformation(
            extent={{-10,-10},{10,10}},
            rotation=180,
            origin={110,30})));
      Modelica.Blocks.Interfaces.RealInput V3(unit="V", start=120) "RMS voltage of the source" annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=180,
            origin={110,0}),   iconTransformation(
            extent={{-10,-10},{10,10}},
            rotation=180,
            origin={110,10})));
      Modelica.Blocks.Interfaces.RealInput f3(unit="Hz", start=60) "Frequency of the source" annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=180,
            origin={110,-10}), iconTransformation(
            extent={{-10,-10},{10,10}},
            rotation=180,
            origin={110,-10})));
    equation
      connect(weaDatInpCon1.weaBus, flexgrid.weaBus) annotation (Line(
          points={{-60,80},{-30,80},{-30,56},{-20,56}},
          color={255,204,51},
          thickness=0.5));
      connect(interface.batt_ctrl2, batt_ctrl2) annotation (Line(points={{-22,-24},{
              -80,-24},{-80,-74},{-110,-74}}, color={0,0,127}));
      connect(interface.batt_ctrl3, batt_ctrl3) annotation (Line(points={{-22,-28},{
              -76,-28},{-76,-88},{-110,-88}}, color={0,0,127}));
      connect(plim1, interface.plim1) annotation (Line(points={{66,-110},{66,-86},{10,
              -86},{10,-32}}, color={0,0,127}));
      connect(plim2, interface.plim2) annotation (Line(points={{80,-110},{80,-84},{14,
              -84},{14,-32}}, color={0,0,127}));
      connect(plim3, interface.plim3) annotation (Line(points={{94,-110},{94,-110},{
              94,-82},{18,-82},{18,-32}}, color={0,0,127}));
      connect(scale1, flexgrid.scale1) annotation (Line(points={{-110,40},{-84,40},{
              -84,44},{-22,44}}, color={0,0,127}));
      connect(scale2, flexgrid.scale2) annotation (Line(points={{-110,26},{-80,26},{
              -80,40},{-22,40}}, color={0,0,127}));
      connect(scale3, flexgrid.scale3) annotation (Line(points={{-110,12},{-76,12},{
              -76,36},{-22,36}}, color={0,0,127}));
      connect(batt_ctrl1, interface.batt_ctrl1) annotation (Line(points={{-110,-60},
              {-84,-60},{-84,-20},{-22,-20}}, color={0,0,127}));
      connect(flexgrid.terminal_p, source.terminal)
        annotation (Line(points={{22,58},{31,58},{40,58}}, color={0,120,120}));
      connect(V1, source.V1) annotation (Line(points={{110,80},{80,80},{80,67},{61,67}},
            color={0,0,127}));
      connect(f1, source.f1)
        annotation (Line(points={{110,66},{61,66},{61,65}}, color={0,0,127}));
      connect(V2, source.V2) annotation (Line(points={{110,50},{86,50},{86,61},{61,61}},
            color={0,0,127}));
      connect(f2, source.f2) annotation (Line(points={{110,30},{84,30},{84,59},{61,59}},
            color={0,0,127}));
      connect(V3, source.V3) annotation (Line(points={{110,0},{82,0},{82,55},{61,55}},
            color={0,0,127}));
      connect(f3, source.f3) annotation (Line(points={{110,-10},{80,-10},{80,53},{61,
              53}}, color={0,0,127}));
      connect(flexgrid.invCtrlBus1, interface.invCtrlBus1) annotation (Line(
          points={{-10,20},{-10,15},{-10,10}},
          color={255,204,51},
          thickness=0.5));
      connect(flexgrid.invCtrlBus2, interface.invCtrlBus2) annotation (Line(
          points={{0,20},{0,15},{0,10}},
          color={255,204,51},
          thickness=0.5));
      connect(flexgrid.invCtrlBus3, interface.invCtrlBus3) annotation (Line(
          points={{10,20},{10,15},{10,10}},
          color={255,204,51},
          thickness=0.5));
      annotation (Icon(coordinateSystem(preserveAspectRatio=false)),
      experiment(StartTime=2.09952e+07, StopTime=2.22039e+07),
      Diagram(coordinateSystem(preserveAspectRatio=false)));
    end FLEXGRID_direct_wye_voltvar_FMU;

    model IEEE13_PV_extBus
      parameter String weaName = "C:/Users/Christoph/Documents/SmartInverter/smartinverter_simulation/ExampleData/USA_CA_San.Francisco.Intl.AP.724940_TMY3_CONVERTED.mos" "Path to weather file";

      Components.Grid.Model.Network ieee13(redeclare
          Components.Grid.Records.IEEE_13 grid, V_nominal=4.16e3/sqrt(3))
        annotation (Placement(transformation(
            extent={{-10,10},{10,-10}},
            rotation=270,
            origin={0,90})));
      Components.Inverter.Model.SpotLoad_Y_PQ_extBus node3 annotation (Placement(
            transformation(
            extent={{-10,-10},{10,10}},
            rotation=90,
            origin={-50,50})));
      Components.Inverter.Model.SpotLoad_D_PQ_extBus node4 annotation (Placement(
            transformation(
            extent={{-10,-10},{10,10}},
            rotation=90,
            origin={-90,50})));
      Components.Inverter.Model.SpotLoad_Y_PQ_extBus node2
        annotation (Placement(transformation(extent={{-20,20},{0,40}})));
      Components.Inverter.Model.SpotLoad_Y_PQ_extBus node6 annotation (Placement(
            transformation(
            extent={{-10,-10},{10,10}},
            rotation=90,
            origin={70,46})));
      Components.Inverter.Model.SpotLoad_Y_PQ_extBus node11 annotation (Placement(
            transformation(
            extent={{-10,-10},{10,10}},
            rotation=90,
            origin={90,-10})));
      Components.Inverter.Model.SpotLoad_D_PQ_extBus node10 annotation (Placement(
            transformation(
            extent={{-10,-10},{10,10}},
            rotation=90,
            origin={42,-16})));
      Components.Inverter.Model.SpotLoad_D_PQ_extBus node7
        annotation (Placement(transformation(extent={{-20,-40},{0,-20}})));
      Components.Inverter.Model.SpotLoad_Y_PQ_extBus node9 annotation (Placement(
            transformation(
            extent={{-10,-10},{10,10}},
            rotation=90,
            origin={-90,-10})));
      Components.Inverter.Model.SpotLoad_Y_PQ_extBus node12
        annotation (Placement(transformation(extent={{-60,-90},{-40,-70}})));
      Buildings.Electrical.AC.ThreePhasesUnbalanced.Sources.Grid node1(f=60, V=4.16e3)
        annotation (Placement(transformation(extent={{40,80},{60,100}})));
      Components.Inverter.Interfaces.LoadCtrlBus ctrlNode4 annotation (Placement(
            transformation(extent={{-110,4},{-90,24}}), iconTransformation(extent={{
                -140,6},{-120,26}})));
      Components.Inverter.Interfaces.LoadCtrlBus ctrlNode2 annotation (Placement(
            transformation(extent={{-110,24},{-90,44}}), iconTransformation(extent={
                {-140,6},{-120,26}})));
      Components.Inverter.Interfaces.LoadCtrlBus ctrlNode3 annotation (Placement(
            transformation(extent={{-110,14},{-90,34}}), iconTransformation(extent={
                {-140,6},{-120,26}})));
      Components.Inverter.Interfaces.LoadCtrlBus ctrlNode6 annotation (Placement(
            transformation(extent={{-110,-6},{-90,14}}), iconTransformation(extent={
                {-140,6},{-120,26}})));
      Components.Inverter.Interfaces.LoadCtrlBus ctrlNode7 annotation (Placement(
            transformation(extent={{-110,-50},{-90,-30}}), iconTransformation(
              extent={{-140,6},{-120,26}})));
      Components.Inverter.Interfaces.LoadCtrlBus ctrlNode9 annotation (Placement(
            transformation(extent={{-110,-40},{-90,-20}}), iconTransformation(
              extent={{-140,6},{-120,26}})));
      Components.Inverter.Interfaces.LoadCtrlBus ctrlNode10 annotation (Placement(
            transformation(extent={{-110,-60},{-90,-40}}), iconTransformation(
              extent={{-140,6},{-120,26}})));
      Components.Inverter.Interfaces.LoadCtrlBus ctrlNode11 annotation (Placement(
            transformation(extent={{-110,-70},{-90,-50}}), iconTransformation(
              extent={{-140,6},{-120,26}})));
      Components.Inverter.Interfaces.LoadCtrlBus ctrlNode12 annotation (Placement(
            transformation(extent={{-110,-80},{-90,-60}}), iconTransformation(
              extent={{-140,6},{-120,26}})));
      Components.Inverter.Model.SpotLoad_Y_PQ_extBus node13
        annotation (Placement(transformation(extent={{-20,-90},{0,-70}})));
      Components.Inverter.Interfaces.LoadCtrlBus ctrlNode13 annotation (Placement(
            transformation(extent={{-110,-90},{-90,-70}}), iconTransformation(
              extent={{-140,6},{-120,26}})));
      generic_wye_voltvar inverter13(weaName=weaName)
        annotation (Placement(transformation(extent={{32,-90},{12,-70}})));
      generic_wye_voltvar inverter11(weaName=weaName)
                                     annotation (Placement(transformation(
            extent={{10,-10},{-10,10}},
            rotation=90,
            origin={90,16})));
      generic_wye_voltvar inverter9(weaName=weaName) annotation (Placement(
            transformation(
            extent={{10,-10},{-10,10}},
            rotation=90,
            origin={-74,18})));
      generic_wye_voltvar inverter6(weaName=weaName)
                                    annotation (Placement(transformation(
            extent={{10,-10},{-10,10}},
            rotation=90,
            origin={90,78})));
      generic_wye_voltvar inverter3(weaName=weaName)
                                    annotation (Placement(transformation(
            extent={{10,-10},{-10,10}},
            rotation=90,
            origin={-50,78})));
      Components.Inverter.Interfaces.InvCtrlBus ctrlInv3 annotation (Placement(
            transformation(extent={{-60,90},{-40,110}}), iconTransformation(extent={
                {-194,18},{-174,38}})));
      Components.Inverter.Interfaces.InvCtrlBus ctrlInv6 annotation (Placement(
            transformation(extent={{80,90},{100,110}}), iconTransformation(extent={{
                -194,18},{-174,38}})));
      Components.Inverter.Interfaces.InvCtrlBus ctrlInv9 annotation (Placement(
            transformation(extent={{-58,8},{-38,28}}), iconTransformation(extent={{-194,
                18},{-174,38}})));
      Components.Inverter.Interfaces.InvCtrlBus ctrlInv11 annotation (Placement(
            transformation(extent={{92,10},{112,30}}), iconTransformation(extent={{-194,
                18},{-174,38}})));
      Components.Inverter.Interfaces.InvCtrlBus ctrlInv13 annotation (Placement(
            transformation(extent={{20,-110},{40,-90}}), iconTransformation(extent={
                {-194,18},{-174,38}})));
    equation
      connect(node4.terminal_n, ieee13.terminal[4]) annotation (Line(points={{-90,60},
              {0,60},{0,80},{-1.77636e-015,80}},     color={0,120,120}));
      connect(node3.terminal_n, ieee13.terminal[3]) annotation (Line(points={{-50,
              60},{0,60},{0,80},{-1.77636e-015,80}}, color={0,120,120}));
      connect(node6.terminal_n, ieee13.terminal[6]) annotation (Line(points={{70,56},
              {0,56},{0,80}},         color={0,120,120}));
      connect(node2.terminal_n, ieee13.terminal[2])
        annotation (Line(points={{0,30},{0,30},{0,80}}, color={0,120,120}));
      connect(node7.terminal_n, ieee13.terminal[7])
        annotation (Line(points={{0,-30},{0,-30},{0,80}}, color={0,120,120}));
      connect(node9.terminal_n, ieee13.terminal[9]) annotation (Line(points={{-90,0},
              {0,0},{0,80},{-1.77636e-015,80}}, color={0,120,120}));
      connect(node12.terminal_n, ieee13.terminal[12]) annotation (Line(points={{-40,-80},
              {-40,-80},{-40,0},{0,0},{0,80}},      color={0,120,120}));
      connect(node10.terminal_n, ieee13.terminal[10]) annotation (Line(points={{42,-6},
              {0,-6},{0,80},{-1.77636e-15,80}},    color={0,120,120}));
      connect(node11.terminal_n, ieee13.terminal[11])
        annotation (Line(points={{90,0},{0,0},{0,80}}, color={0,120,120}));
      connect(node1.terminal, ieee13.terminal[1])
        annotation (Line(points={{50,80},{0,80}},           color={0,120,120}));
      connect(node12.ctrls, ctrlNode12) annotation (Line(
          points={{-60,-80},{-60,-80},{-70,-80},{-70,-70},{-100,-70}},
          color={255,204,51},
          thickness=0.5), Text(
          string="%second",
          index=1,
          extent={{6,3},{6,3}}));
      connect(ctrlNode11, node11.ctrls) annotation (Line(
          points={{-100,-60},{90,-60},{90,-20}},
          color={255,204,51},
          thickness=0.5), Text(
          string="%first",
          index=-1,
          extent={{-6,3},{-6,3}}));
      connect(ctrlNode10, node10.ctrls) annotation (Line(
          points={{-100,-50},{42,-50},{42,-26}},
          color={255,204,51},
          thickness=0.5), Text(
          string="%first",
          index=-1,
          extent={{-6,3},{-6,3}}));
      connect(node9.ctrls, ctrlNode9) annotation (Line(
          points={{-90,-20},{-90,-20},{-90,-30},{-100,-30}},
          color={255,204,51},
          thickness=0.5), Text(
          string="%second",
          index=1,
          extent={{6,3},{6,3}}));
      connect(ctrlNode7, node7.ctrls) annotation (Line(
          points={{-100,-40},{-60,-40},{-60,-30},{-20,-30}},
          color={255,204,51},
          thickness=0.5), Text(
          string="%first",
          index=-1,
          extent={{-6,3},{-6,3}}));
      connect(ctrlNode6, node6.ctrls) annotation (Line(
          points={{-100,4},{20,4},{20,36},{70,36}},
          color={255,204,51},
          thickness=0.5), Text(
          string="%first",
          index=-1,
          extent={{-6,3},{-6,3}}));
      connect(ctrlNode2, node2.ctrls) annotation (Line(
          points={{-100,34},{-60,34},{-60,30},{-20,30}},
          color={255,204,51},
          thickness=0.5), Text(
          string="%first",
          index=-1,
          extent={{-6,3},{-6,3}}));
      connect(ctrlNode3, node3.ctrls) annotation (Line(
          points={{-100,24},{-50,24},{-50,40},{-50,40}},
          color={255,204,51},
          thickness=0.5), Text(
          string="%first",
          index=-1,
          extent={{-6,3},{-6,3}}));
      connect(ctrlNode4, node4.ctrls) annotation (Line(
          points={{-100,14},{-90,14},{-90,40}},
          color={255,204,51},
          thickness=0.5), Text(
          string="%first",
          index=-1,
          extent={{-6,3},{-6,3}}));
      connect(node13.terminal_n, ieee13.terminal[13])
        annotation (Line(points={{0,-80},{0,80},{0,80}}, color={0,120,120}));
      connect(node13.ctrls, ctrlNode13) annotation (Line(
          points={{-20,-80},{-28,-80},{-28,-94},{-80,-94},{-80,-80},{-100,-80}},
          color={255,204,51},
          thickness=0.5), Text(
          string="%second",
          index=1,
          extent={{6,3},{6,3}}));
      connect(inverter9.terminal_p, ieee13.terminal[9])
        annotation (Line(points={{-74,7},{8,7},{8,80},{0,80}}, color={0,120,120}));
      connect(inverter6.terminal_p, ieee13.terminal[6])
        annotation (Line(points={{90,67},{90,69},{2,69},{2,80},{-1.77636e-15,80}},
                                                   color={0,120,120}));
      connect(inverter3.terminal_p, ieee13.terminal[3])
        annotation (Line(points={{-50,67},{-50,70},{-1.77636e-15,70},{-1.77636e-15,80}},
                                                     color={0,120,120}));
      connect(inverter3.invCtrlBus, ctrlInv3) annotation (Line(
          points={{-50,88},{-50,100}},
          color={255,204,51},
          thickness=0.5), Text(
          string="%second",
          index=1,
          extent={{-3,6},{-3,6}},
          horizontalAlignment=TextAlignment.Right));
      connect(inverter6.invCtrlBus, ctrlInv6) annotation (Line(
          points={{90,88},{90,100}},
          color={255,204,51},
          thickness=0.5), Text(
          string="%second",
          index=1,
          extent={{-3,6},{-3,6}},
          horizontalAlignment=TextAlignment.Right));
      connect(inverter11.invCtrlBus, ctrlInv11) annotation (Line(
          points={{90,26},{96,26},{96,20},{102,20}},
          color={255,204,51},
          thickness=0.5), Text(
          string="%second",
          index=1,
          extent={{6,3},{6,3}},
          horizontalAlignment=TextAlignment.Left));
      connect(inverter13.invCtrlBus, ctrlInv13) annotation (Line(
          points={{32,-80},{26,-80},{26,-100},{30,-100}},
          color={255,204,51},
          thickness=0.5), Text(
          string="%second",
          index=1,
          extent={{6,3},{6,3}},
          horizontalAlignment=TextAlignment.Left));
      connect(inverter11.terminal_p, ieee13.terminal[11])
        annotation (Line(points={{90,5},{90,4},{56,4},{56,80},{-1.77636e-15,80}},
                                                  color={0,120,120}));
      connect(inverter13.terminal_p, ieee13.terminal[13])
        annotation (Line(points={{11,-80},{6,-80},{6,80},{0,80}},
                                                    color={0,120,120}));
      connect(inverter9.invCtrlBus, ctrlInv9) annotation (Line(
          points={{-74,28},{-62,28},{-62,18},{-48,18}},
          color={255,204,51},
          thickness=0.5), Text(
          string="%second",
          index=1,
          extent={{6,3},{6,3}}));
      annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
            coordinateSystem(preserveAspectRatio=false)));
    end IEEE13_PV_extBus;

    model generic_wye_voltvar
      parameter Real V_nominal(min=0, unit="V") = 240 "Nominal sytem voltage to scale Vp.u.";
      parameter Real v_max( start=1.05, unit="1")=1.05 "Voltage maximum [p.u.]";
      parameter Real v_maxdead( start=1.01, unit="1")=1.01 "Upper bound of deadband [p.u.]";
      parameter Real v_mindead( start=0.99, unit="1")=0.99 "Upper bound of deadband [p.u.]";
      parameter Real v_min( start=0.95, unit="1")=0.95 "Voltage minimum [p.u.]";
      parameter Real q_maxind( start=1000, unit="var")=2500 "Maximal Reactive Power (Inductive) [var]";
      parameter Real q_maxcap( start=1000, unit="var")=2500 "Maximal Reactive Power (Capacitive) [var]";
      parameter String weaName = "C:/Users/Christoph/Documents/SmartInverter/smartinverter_simulation/ExampleData/USA_CA_San.Francisco.Intl.AP.724940_TMY3_CONVERTED.mos" "Path to weather file";
      parameter Real n(min=0, unit="1") = 14 "Number of PV modules";
      parameter Modelica.SIunits.Area A(min=0) = 1.65 "Net surface area per module [m2]";
      parameter Real lat(unit="deg") = 37.9 "Latitude [deg]";
      parameter Real til(unit="deg") = 10 "Surface tilt [deg]";
      parameter Real azi(unit="deg") = 0 "Surface azimuth [deg] 0-S, 90-W, 180-N, 270-E ";
      parameter Real Smax(min=0, unit="VA") = 7600
        "Maximal apparent power";
      parameter Real QIndmax(min=0, unit="var") = 2500
        "Maximal reactive power (Inductive)";
      parameter Real QCapmax(min=0, unit="var") = 2500
        "Maximal reactive power (Capacitive)";

      generic_direct_wye  generic(
        n=n,
        A=A,
        lat=lat,
        til=til,
        azi=azi,
        Smax=Smax,
        QIndmax=QIndmax,
        QCapmax=QCapmax)
        annotation (Placement(transformation(extent={{-20,20},{20,60}})));
      Buildings.BoundaryConditions.WeatherData.ReaderTMY3 weaDatInpCon1(
        computeWetBulbTemperature=false, filNam=weaName)
        "Weather data reader with radiation data obtained from the inputs' connectors"
        annotation (Placement(transformation(extent={{-80,70},{-60,90}})));
      Interfaces.generic_interface_voltvar interface_voltvar(
        V_nominal=V_nominal,
        v_max=v_max,
        v_maxdead=v_maxdead,
        v_mindead=v_mindead,
        v_min=v_min,
        q_maxind=q_maxind,
        q_maxcap=q_maxcap)
        annotation (Placement(transformation(extent={{-20,-30},{20,10}})));
      Buildings.Electrical.AC.ThreePhasesUnbalanced.Interfaces.Terminal_p
                 terminal_p "Electric terminal side p"
        annotation (Placement(transformation(extent={{100,-10},{120,10}}),
            iconTransformation(extent={{100,-10},{120,10}})));
      Modelica.Blocks.Sources.Constant const_scale(k=1)
        annotation (Placement(transformation(extent={{-70,30},{-50,50}})));
      Components.Inverter.Interfaces.InvCtrlBus invCtrlBus annotation (Placement(
            transformation(extent={{-120,-40},{-80,0}}), iconTransformation(extent={
                {-110,-10},{-90,10}})));
    equation
      connect(weaDatInpCon1.weaBus, generic.weaBus) annotation (Line(
          points={{-60,80},{-30,80},{-30,56},{-20,56}},
          color={255,204,51},
          thickness=0.5));
      connect(generic.invCtrlBus1, interface_voltvar.invCtrlBus1) annotation (Line(
          points={{-10,20},{-10,15},{-10,10}},
          color={255,204,51},
          thickness=0.5));
      connect(generic.invCtrlBus2, interface_voltvar.invCtrlBus2) annotation (Line(
          points={{0,20},{0,15},{0,10}},
          color={255,204,51},
          thickness=0.5));
      connect(generic.invCtrlBus3, interface_voltvar.invCtrlBus3) annotation (Line(
          points={{10,20},{10,15},{10,10}},
          color={255,204,51},
          thickness=0.5));
      connect(terminal_p, generic.terminal_p) annotation (Line(points={{110,0},{60,0},
              {60,58},{22,58}}, color={0,120,120}));
      connect(interface_voltvar.invCtrlBus, invCtrlBus) annotation (Line(
          points={{-20,-10},{-60,-10},{-60,-20},{-100,-20}},
          color={255,204,51},
          thickness=0.5), Text(
          string="%second",
          index=1,
          extent={{-6,3},{-6,3}},
          horizontalAlignment=TextAlignment.Right));
      connect(const_scale.y, generic.scale2)
        annotation (Line(points={{-49,40},{-22,40}}, color={0,0,127}));
      connect(generic.scale1, const_scale.y) annotation (Line(points={{-22,44},{-34,
              44},{-34,40},{-49,40}}, color={0,0,127}));
      connect(generic.scale3, const_scale.y) annotation (Line(points={{-22,36},{-34,
              36},{-34,40},{-49,40}}, color={0,0,127}));
      annotation (Icon(coordinateSystem(preserveAspectRatio=false)),
      experiment(StartTime=2.09952e+07, StopTime=2.22039e+07),
      Diagram(coordinateSystem(preserveAspectRatio=false)));
    end generic_wye_voltvar;

    model generic_direct_wye
      import SmartInverter = SCooDER;
      parameter Real n(min=0, unit="1") = 14 "Number of PV modules";
      parameter Modelica.SIunits.Area A(min=0) = 1.65 "Net surface area per module [m2]";
      parameter Real lat(unit="deg") = 37.9 "Latitude [deg]";
      parameter Real til(unit="deg") = 10 "Surface tilt [deg]";
      parameter Real azi(unit="deg") = 0 "Surface azimuth [deg] 0-S, 90-W, 180-N, 270-E ";
      parameter Real Smax(min=0, unit="VA") = 7600
        "Maximal apparent power";
      parameter Real QIndmax(min=0, unit="var") = 2500
        "Maximal reactive power (Inductive)";
      parameter Real QCapmax(min=0, unit="var") = 2500
        "Maximal reactive power (Capacitive)";

      SmartInverter.Components.Sensor.Model.Probe3ph sens_FLEXGRID(V_nominal=208)
        annotation (Placement(transformation(
            extent={{10,-10},{-10,10}},
            rotation=90,
            origin={90,40})));
      Modelica.Blocks.Interfaces.RealInput scale3(start=1,
        min=0,
        max=1,
        unit="1") "Shading of PV module" annotation (Placement(transformation(
            origin={-110,12},
            extent={{10,10},{-10,-10}},
            rotation=180), iconTransformation(
            extent={{-10,-10},{10,10}},
            rotation=0,
            origin={-110,-20})));
      Modelica.Blocks.Interfaces.RealInput scale1(start=1,
        min=0,
        max=1,
        unit="1") "Shading of PV module" annotation (Placement(transformation(
            origin={-110,40},
            extent={{10,10},{-10,-10}},
            rotation=180), iconTransformation(
            extent={{-10,-10},{10,10}},
            rotation=0,
            origin={-110,20})));
      Modelica.Blocks.Interfaces.RealInput scale2(start=1,
        min=0,
        max=1,
        unit="1") "Shading of PV module" annotation (Placement(transformation(
            origin={-110,26},
            extent={{10,10},{-10,-10}},
            rotation=180), iconTransformation(
            extent={{-10,-10},{10,10}},
            rotation=0,
            origin={-110,0})));
      SmartInverter.Components.Battery.Model.Battery battery1
        annotation (Placement(transformation(extent={{-30,30},{-10,50}})));
      SmartInverter.Components.Battery.Model.Battery battery2
        annotation (Placement(transformation(extent={{-30,-10},{-10,10}})));
      SmartInverter.Components.Battery.Model.Battery battery3
        annotation (Placement(transformation(extent={{-30,-50},{-10,-30}})));
      SmartInverter.Components.Photovoltaics.Model.PVModule_simple pv1(
        n=n,
        A=A,
        lat=lat,
        til=til,
        azi=azi)
        annotation (Placement(transformation(extent={{-64,46},{-44,66}})));
      SmartInverter.Components.Photovoltaics.Model.PVModule_simple pv2(
        n=n,
        A=A,
        lat=lat,
        til=til,
        azi=azi)
        annotation (Placement(transformation(extent={{-64,6},{-44,26}})));
      SmartInverter.Components.Photovoltaics.Model.PVModule_simple pv3(
        n=n,
        A=A,
        lat=lat,
        til=til,
        azi=azi)
        annotation (Placement(transformation(extent={{-64,-34},{-44,-14}})));
      Buildings.BoundaryConditions.WeatherData.Bus
                      weaBus "Bus with weather data"
        annotation (Placement(transformation(extent={{-110,70},{-90,90}})));
      Buildings.Electrical.AC.ThreePhasesUnbalanced.Lines.TwoPortMatrixRL FL_feed(
        Z12=20*(1.0/5280.0)*{0.0953,0.8515},
        Z13=20*(1.0/5280.0)*{0.0953,0.7266},
        Z23=20*(1.0/5280.0)*{0.0953,0.7802},
        V_nominal=208,
        Z11=20*(1.0/5280.0)*{0.4013,1.4133},
        Z22=20*(1.0/5280.0)*{0.4013,1.4133},
        Z33=20*(1.0/5280.0)*{0.4013,1.4133}) annotation (Placement(transformation(
            extent={{-10,10},{10,-10}},
            rotation=-90,
            origin={90,70})));

      Buildings.Electrical.AC.ThreePhasesUnbalanced.Interfaces.Terminal_p
                 terminal_p "Electric terminal side p"
        annotation (Placement(transformation(extent={{100,80},{120,100}}),
            iconTransformation(extent={{100,80},{120,100}})));
      SmartInverter.Components.Inverter.Model.Inverter inverter1(
        Smax=Smax,
        QIndmax=QIndmax,
        QCapmax=QCapmax)
        annotation (Placement(transformation(extent={{26,40},{6,60}})));
      SmartInverter.Components.Inverter.Model.Inverter inverter2(
        Smax=Smax,
        QCapmax=QCapmax,
        QIndmax=QIndmax)
        annotation (Placement(transformation(extent={{26,0},{6,20}})));
      SmartInverter.Components.Inverter.Model.Inverter inverter3(
        Smax=Smax,
        QIndmax=QIndmax,
        QCapmax=QCapmax)
        annotation (Placement(transformation(extent={{26,-40},{6,-20}})));
      SmartInverter.Components.Inverter.Interfaces.InvCtrlBus
                                                         invCtrlBus1
                                                                    annotation (
          Placement(transformation(extent={{-60,-110},{-40,-90}}),
                                                                 iconTransformation(
              extent={{-60,-110},{-40,-90}})));
      SmartInverter.Components.Inverter.Interfaces.InvCtrlBus
                                                         invCtrlBus2
                                                                    annotation (
          Placement(transformation(extent={{-10,-110},{10,-90}}),iconTransformation(
              extent={{-10,-110},{10,-90}})));
      SmartInverter.Components.Inverter.Interfaces.InvCtrlBus
                                                         invCtrlBus3
                                                                    annotation (
          Placement(transformation(extent={{40,-110},{60,-90}}), iconTransformation(
              extent={{40,-110},{60,-90}})));
      Buildings.Electrical.AC.ThreePhasesUnbalanced.Interfaces.Adapter3to3 wye
        annotation (Placement(transformation(extent={{60,0},{80,20}})));
    equation
      connect(inverter2.P_PV, pv2.P)
        annotation (Line(points={{4,16},{-20,16},{-43,16}},
                                                 color={0,0,127}));
      connect(inverter3.P_PV, pv3.P)
        annotation (Line(points={{4,-24},{-20,-24},{-43,-24}},
                                                     color={0,0,127}));
      connect(inverter1.P_PV, pv1.P)
        annotation (Line(points={{4,56},{-20,56},{-43,56}},
                                                   color={0,0,127}));
      connect(inverter3.P_Batt, battery3.P_batt) annotation (Line(points={{4,-33},{
              -4,-33},{-4,-40},{-9,-40}}, color={0,0,127}));
      connect(inverter2.P_Batt, battery2.P_batt)
        annotation (Line(points={{4,7},{-4,7},{-4,0},{-9,0}}, color={0,0,127}));
      connect(inverter1.P_Batt, battery1.P_batt) annotation (Line(points={{4,47},{
              -4,47},{-4,40},{-9,40}}, color={0,0,127}));
      connect(scale1, pv1.scale)
        annotation (Line(points={{-110,40},{-66,40},{-66,52}}, color={0,0,127}));
      connect(scale2, pv2.scale) annotation (Line(points={{-110,26},{-92,26},{-92,
              12},{-66,12}},
                        color={0,0,127}));
      connect(scale3, pv3.scale) annotation (Line(points={{-110,12},{-94,12},{-94,
              -28},{-66,-28}},
                          color={0,0,127}));
      connect(pv1.weaBus, weaBus) annotation (Line(
          points={{-64,60},{-80,60},{-80,80},{-100,80}},
          color={255,204,51},
          thickness=0.5), Text(
          string="%second",
          index=1,
          extent={{6,3},{6,3}}));
      connect(pv2.weaBus, weaBus) annotation (Line(
          points={{-64,20},{-80,20},{-80,80},{-100,80}},
          color={255,204,51},
          thickness=0.5), Text(
          string="%second",
          index=1,
          extent={{6,3},{6,3}}));
      connect(pv3.weaBus, weaBus) annotation (Line(
          points={{-64,-20},{-80,-20},{-80,80},{-100,80}},
          color={255,204,51},
          thickness=0.5), Text(
          string="%second",
          index=1,
          extent={{6,3},{6,3}}));
      connect(FL_feed.terminal_p, sens_FLEXGRID.terminal_n)
        annotation (Line(points={{90,60},{90,50}}, color={0,120,120}));
      connect(FL_feed.terminal_n, terminal_p) annotation (Line(points={{90,80},{90,
              80},{90,90},{110,90}}, color={0,120,120}));
      connect(inverter3.batt_ctrl_inv, battery3.P_ctrl) annotation (Line(points={{5,
              -38},{0,-38},{0,-54},{-40,-54},{-40,-40},{-32,-40}}, color={0,0,127}));
      connect(inverter2.batt_ctrl_inv, battery2.P_ctrl) annotation (Line(points={{5,
              2},{0,2},{0,-14},{-40,-14},{-40,0},{-32,0}}, color={0,0,127}));
      connect(inverter1.batt_ctrl_inv, battery1.P_ctrl) annotation (Line(points={{5,
              42},{0,42},{0,26},{-40,26},{-40,40},{-32,40}}, color={0,0,127}));
      connect(invCtrlBus3, inverter3.invCtrlBus) annotation (Line(
          points={{50,-100},{50,-100},{50,-54},{16,-54},{16,-40}},
          color={255,204,51},
          thickness=0.5), Text(
          string="%first",
          index=-1,
          extent={{-6,3},{-6,3}}));
      connect(inverter2.invCtrlBus, invCtrlBus2) annotation (Line(
          points={{16,0},{16,0},{16,-14},{34,-14},{34,-86},{0,-86},{0,-100}},
          color={255,204,51},
          thickness=0.5), Text(
          string="%second",
          index=1,
          extent={{6,3},{6,3}}));
      connect(inverter1.invCtrlBus, invCtrlBus1) annotation (Line(
          points={{16,40},{16,40},{16,26},{32,26},{32,-84},{-50,-84},{-50,-100}},
          color={255,204,51},
          thickness=0.5), Text(
          string="%second",
          index=1,
          extent={{6,3},{6,3}}));
      connect(sens_FLEXGRID.terminal_p, wye.terminal) annotation (Line(points={{90,
              30},{90,30},{90,10},{80,10}}, color={0,120,120}));
      connect(inverter1.term_p, wye.terminals[1]) annotation (Line(points={{26,50},
              {38,50},{38,50},{50,50},{50,10.5333},{60.2,10.5333}}, color={0,120,
              120}));
      connect(inverter2.term_p, wye.terminals[2])
        annotation (Line(points={{26,10},{60.2,10},{60.2,10}}, color={0,120,120}));
      connect(inverter3.term_p, wye.terminals[3]) annotation (Line(points={{26,-30},
              {50,-30},{50,9.46667},{60.2,9.46667}}, color={0,120,120}));
      annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
            coordinateSystem(preserveAspectRatio=false)));
    end generic_direct_wye;

    model IEEE13_PV_extBus_test
      parameter String weaName = "C:/Users/Christoph/Documents/SmartInverter/smartinverter_simulation/ExampleData/USA_CA_San.Francisco.Intl.AP.724940_TMY3_CONVERTED.mos" "Path to weather file";

      Components.Grid.Model.Network ieee13(redeclare
          Components.Grid.Records.IEEE_13 grid, V_nominal=4.16e3/sqrt(3))
        annotation (Placement(transformation(
            extent={{-10,10},{10,-10}},
            rotation=270,
            origin={0,90})));
      Components.Inverter.Model.SpotLoad_Y_PQ_extBus node3 annotation (Placement(
            transformation(
            extent={{-10,-10},{10,10}},
            rotation=90,
            origin={-50,50})));
      Components.Inverter.Model.SpotLoad_D_PQ_extBus node4 annotation (Placement(
            transformation(
            extent={{-10,-10},{10,10}},
            rotation=90,
            origin={-90,50})));
      Components.Inverter.Model.SpotLoad_Y_PQ_extBus node2
        annotation (Placement(transformation(extent={{-20,20},{0,40}})));
      Components.Inverter.Model.SpotLoad_Y_PQ_extBus node6 annotation (Placement(
            transformation(
            extent={{-10,-10},{10,10}},
            rotation=90,
            origin={90,50})));
      Components.Inverter.Model.SpotLoad_Y_PQ_extBus node11 annotation (Placement(
            transformation(
            extent={{-10,-10},{10,10}},
            rotation=90,
            origin={90,-10})));
      Components.Inverter.Model.SpotLoad_D_PQ_extBus node10 annotation (Placement(
            transformation(
            extent={{-10,-10},{10,10}},
            rotation=90,
            origin={40,-10})));
      Components.Inverter.Model.SpotLoad_D_PQ_extBus node7
        annotation (Placement(transformation(extent={{-20,-40},{0,-20}})));
      Components.Inverter.Model.SpotLoad_Y_PQ_extBus node9 annotation (Placement(
            transformation(
            extent={{-10,-10},{10,10}},
            rotation=90,
            origin={-90,-10})));
      Components.Inverter.Model.SpotLoad_Y_PQ_extBus node12
        annotation (Placement(transformation(extent={{-60,-90},{-40,-70}})));
      Buildings.Electrical.AC.ThreePhasesUnbalanced.Sources.Grid node1(f=60, V=4.16e3)
        annotation (Placement(transformation(extent={{40,80},{60,100}})));
      Components.Inverter.Interfaces.LoadCtrlBus ctrlNode4 annotation (Placement(
            transformation(extent={{-110,4},{-90,24}}), iconTransformation(extent={{
                -140,6},{-120,26}})));
      Components.Inverter.Interfaces.LoadCtrlBus ctrlNode2 annotation (Placement(
            transformation(extent={{-110,24},{-90,44}}), iconTransformation(extent={
                {-140,6},{-120,26}})));
      Components.Inverter.Interfaces.LoadCtrlBus ctrlNode3 annotation (Placement(
            transformation(extent={{-110,14},{-90,34}}), iconTransformation(extent={
                {-140,6},{-120,26}})));
      Components.Inverter.Interfaces.LoadCtrlBus ctrlNode6 annotation (Placement(
            transformation(extent={{-110,-6},{-90,14}}), iconTransformation(extent={
                {-140,6},{-120,26}})));
      Components.Inverter.Interfaces.LoadCtrlBus ctrlNode7 annotation (Placement(
            transformation(extent={{-110,-50},{-90,-30}}), iconTransformation(
              extent={{-140,6},{-120,26}})));
      Components.Inverter.Interfaces.LoadCtrlBus ctrlNode9 annotation (Placement(
            transformation(extent={{-110,-40},{-90,-20}}), iconTransformation(
              extent={{-140,6},{-120,26}})));
      Components.Inverter.Interfaces.LoadCtrlBus ctrlNode10 annotation (Placement(
            transformation(extent={{-110,-60},{-90,-40}}), iconTransformation(
              extent={{-140,6},{-120,26}})));
      Components.Inverter.Interfaces.LoadCtrlBus ctrlNode11 annotation (Placement(
            transformation(extent={{-110,-70},{-90,-50}}), iconTransformation(
              extent={{-140,6},{-120,26}})));
      Components.Inverter.Interfaces.LoadCtrlBus ctrlNode12 annotation (Placement(
            transformation(extent={{-110,-80},{-90,-60}}), iconTransformation(
              extent={{-140,6},{-120,26}})));
      Components.Inverter.Model.SpotLoad_Y_PQ_extBus node13
        annotation (Placement(transformation(extent={{-20,-90},{0,-70}})));
      Components.Inverter.Interfaces.LoadCtrlBus ctrlNode13 annotation (Placement(
            transformation(extent={{-110,-90},{-90,-70}}), iconTransformation(
              extent={{-140,6},{-120,26}})));
      generic_wye_voltvar inverter13(weaName=weaName)
        annotation (Placement(transformation(extent={{20,-90},{0,-70}})));
      Components.Inverter.Interfaces.InvCtrlBus ctrlInv13 annotation (Placement(
            transformation(extent={{20,-110},{40,-90}}), iconTransformation(extent={
                {-194,18},{-174,38}})));
    equation
      connect(node4.terminal_n, ieee13.terminal[4]) annotation (Line(points={{-90,60},
              {0,60},{0,80},{-1.77636e-015,80}},     color={0,120,120}));
      connect(node3.terminal_n, ieee13.terminal[3]) annotation (Line(points={{-50,
              60},{0,60},{0,80},{-1.77636e-015,80}}, color={0,120,120}));
      connect(node6.terminal_n, ieee13.terminal[6]) annotation (Line(points={{90,60},
              {46,60},{0,60},{0,80}}, color={0,120,120}));
      connect(node2.terminal_n, ieee13.terminal[2])
        annotation (Line(points={{0,30},{0,30},{0,80}}, color={0,120,120}));
      connect(node7.terminal_n, ieee13.terminal[7])
        annotation (Line(points={{0,-30},{0,-30},{0,80}}, color={0,120,120}));
      connect(node9.terminal_n, ieee13.terminal[9]) annotation (Line(points={{-90,0},
              {0,0},{0,80},{-1.77636e-015,80}}, color={0,120,120}));
      connect(node12.terminal_n, ieee13.terminal[12]) annotation (Line(points={{-40,-80},
              {-40,-80},{-40,0},{0,0},{0,80}},      color={0,120,120}));
      connect(node10.terminal_n, ieee13.terminal[10]) annotation (Line(points={{40,
              0},{0,0},{0,80},{-1.77636e-015,80}}, color={0,120,120}));
      connect(node11.terminal_n, ieee13.terminal[11])
        annotation (Line(points={{90,0},{0,0},{0,80}}, color={0,120,120}));
      connect(node1.terminal, ieee13.terminal[1])
        annotation (Line(points={{50,80},{0,80}},           color={0,120,120}));
      connect(node12.ctrls, ctrlNode12) annotation (Line(
          points={{-60,-80},{-60,-80},{-70,-80},{-70,-70},{-100,-70}},
          color={255,204,51},
          thickness=0.5), Text(
          string="%second",
          index=1,
          extent={{6,3},{6,3}}));
      connect(ctrlNode11, node11.ctrls) annotation (Line(
          points={{-100,-60},{90,-60},{90,-20}},
          color={255,204,51},
          thickness=0.5), Text(
          string="%first",
          index=-1,
          extent={{-6,3},{-6,3}}));
      connect(ctrlNode10, node10.ctrls) annotation (Line(
          points={{-100,-50},{40,-50},{40,-20}},
          color={255,204,51},
          thickness=0.5), Text(
          string="%first",
          index=-1,
          extent={{-6,3},{-6,3}}));
      connect(node9.ctrls, ctrlNode9) annotation (Line(
          points={{-90,-20},{-90,-20},{-90,-30},{-100,-30}},
          color={255,204,51},
          thickness=0.5), Text(
          string="%second",
          index=1,
          extent={{6,3},{6,3}}));
      connect(ctrlNode7, node7.ctrls) annotation (Line(
          points={{-100,-40},{-60,-40},{-60,-30},{-20,-30}},
          color={255,204,51},
          thickness=0.5), Text(
          string="%first",
          index=-1,
          extent={{-6,3},{-6,3}}));
      connect(ctrlNode6, node6.ctrls) annotation (Line(
          points={{-100,4},{20,4},{20,36},{90,36},{90,40}},
          color={255,204,51},
          thickness=0.5), Text(
          string="%first",
          index=-1,
          extent={{-6,3},{-6,3}}));
      connect(ctrlNode2, node2.ctrls) annotation (Line(
          points={{-100,34},{-60,34},{-60,30},{-20,30}},
          color={255,204,51},
          thickness=0.5), Text(
          string="%first",
          index=-1,
          extent={{-6,3},{-6,3}}));
      connect(ctrlNode3, node3.ctrls) annotation (Line(
          points={{-100,24},{-50,24},{-50,40},{-50,40}},
          color={255,204,51},
          thickness=0.5), Text(
          string="%first",
          index=-1,
          extent={{-6,3},{-6,3}}));
      connect(ctrlNode4, node4.ctrls) annotation (Line(
          points={{-100,14},{-90,14},{-90,40}},
          color={255,204,51},
          thickness=0.5), Text(
          string="%first",
          index=-1,
          extent={{-6,3},{-6,3}}));
      connect(node13.terminal_n, ieee13.terminal[13])
        annotation (Line(points={{0,-80},{0,80},{0,80}}, color={0,120,120}));
      connect(node13.ctrls, ctrlNode13) annotation (Line(
          points={{-20,-80},{-28,-80},{-28,-94},{-80,-94},{-80,-80},{-100,-80}},
          color={255,204,51},
          thickness=0.5), Text(
          string="%second",
          index=1,
          extent={{6,3},{6,3}}));
      connect(inverter13.terminal_p, ieee13.terminal[13])
        annotation (Line(points={{-1,-80},{0,-80},{0,80},{0,80}},
                                                    color={0,120,120}));
      connect(inverter13.invCtrlBus, ctrlInv13) annotation (Line(
          points={{20,-80},{26,-80},{26,-100},{30,-100}},
          color={255,204,51},
          thickness=0.5), Text(
          string="%second",
          index=1,
          extent={{6,3},{6,3}},
          horizontalAlignment=TextAlignment.Left));
      annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
            coordinateSystem(preserveAspectRatio=false)));
    end IEEE13_PV_extBus_test;

    model generic_wye_voltvarwatt_simple
      parameter Real V_nominal(min=0, unit="V") = 240 "Nominal sytem voltage to scale Vp.u.";
      /*parameter Real v_max( start=1.05, unit="1")=1.05 "Voltage maximum [p.u.]";
  parameter Real v_maxdead( start=1.01, unit="1")=1.01 "Upper bound of deadband [p.u.]";
  parameter Real v_mindead( start=0.99, unit="1")=0.99 "Upper bound of deadband [p.u.]";
  parameter Real v_min( start=0.95, unit="1")=0.95 "Voltage minimum [p.u.]";
  parameter Real q_maxind( start=1000, unit="var")=2500 "Maximal Reactive Power (Inductive) [var]";
  parameter Real q_maxcap( start=1000, unit="var")=2500 "Maximal Reactive Power (Capacitive) [var]";*/
      parameter String weaName = "C:/Users/Christoph/Documents/SmartInverter/smartinverter_simulation/ExampleData/USA_CA_San.Francisco.Intl.AP.724940_TMY3_CONVERTED.mos" "Path to weather file";
      parameter Real n(min=0, unit="1") = 14 "Number of PV modules";
      parameter Modelica.SIunits.Area A(min=0) = 1.65 "Net surface area per module [m2]";
      parameter Real lat(unit="deg") = 37.9 "Latitude [deg]";
      parameter Real til(unit="deg") = 10 "Surface tilt [deg]";
      parameter Real azi(unit="deg") = 0 "Surface azimuth [deg] 0-S, 90-W, 180-N, 270-E ";
      parameter Real Smax(min=0, unit="VA") = 7600
        "Maximal apparent power";
      parameter Real QIndmax(min=0, unit="var") = 2500
        "Maximal reactive power (Inductive)";
      parameter Real QCapmax(min=0, unit="var") = 2500
        "Maximal reactive power (Capacitive)";
      // VoltVarWatt
      parameter Real thrP = 0.05 "P: over/undervoltage threshold";
      parameter Real hysP= 0.04 "P: Hysteresis";
      parameter Real thrQ = 0.04 "Q: over/undervoltage threshold";
      parameter Real hysQ = 0.01 "Q: Hysteresis";
      parameter Real Tfirstorder(unit="s") = 1 "Time constant of first order";

      Buildings.BoundaryConditions.WeatherData.ReaderTMY3 weaDatInpCon1(
        computeWetBulbTemperature=false, filNam=weaName)
        "Weather data reader with radiation data obtained from the inputs' connectors"
        annotation (Placement(transformation(extent={{-90,70},{-70,90}})));
      Buildings.Electrical.AC.ThreePhasesUnbalanced.Interfaces.Terminal_p
                 terminal_p "Electric terminal side p"
        annotation (Placement(transformation(extent={{100,-10},{120,10}}),
            iconTransformation(extent={{100,-10},{120,10}})));
      Components.Inverter.Interfaces.InvCtrlBus invCtrlBus annotation (Placement(
            transformation(extent={{-120,-40},{-80,0}}), iconTransformation(extent={
                {-110,-10},{-90,10}})));
      Buildings.Electrical.AC.ThreePhasesUnbalanced.Interfaces.Adapter3to3 wye
        annotation (Placement(transformation(extent={{70,-10},{90,10}})));
      Components.Inverter.Model.InverterLoad_PQ load1(V_start=120)
        annotation (Placement(transformation(extent={{36,50},{16,30}})));
      Modelica.Blocks.Math.Gain kW_to_W1(k=1000)
        annotation (Placement(transformation(extent={{-10,42},{-4,48}})));
      Modelica.Blocks.Math.Gain kvar_to_var1(k=1000)
        annotation (Placement(transformation(extent={{-10,32},{-4,38}})));
      Components.Controller.Model.Pv_Inv_VoltVarWatt_simple_Slim_weabus inv1(
        n=n,
        A=A,
        lat=lat,
        til=til,
        azi=azi,
        SMax=Smax/1000,
        QMaxInd=QIndmax/1000,
        QMaxCap=QCapmax/1000,
        thrP=thrP,
        hysP=hysP,
        thrQ=thrQ,
        hysQ=hysQ)
        annotation (Placement(transformation(extent={{-44,30},{-24,50}})));
      Components.Inverter.Model.InverterLoad_PQ load2(V_start=120)
        annotation (Placement(transformation(extent={{36,10},{16,-10}})));
      Modelica.Blocks.Math.Gain kW_to_W2(k=1000)
        annotation (Placement(transformation(extent={{-10,2},{-4,8}})));
      Modelica.Blocks.Math.Gain kvar_to_var2(k=1000)
        annotation (Placement(transformation(extent={{-10,-8},{-4,-2}})));
      Components.Controller.Model.Pv_Inv_VoltVarWatt_simple_Slim_weabus inv2(
        n=n,
        A=A,
        lat=lat,
        til=til,
        azi=azi,
        SMax=Smax/1000,
        QMaxInd=QIndmax/1000,
        QMaxCap=QCapmax/1000,
        thrP=thrP,
        hysP=hysP,
        thrQ=thrQ,
        hysQ=hysQ)
        annotation (Placement(transformation(extent={{-44,-10},{-24,10}})));
      Components.Inverter.Model.InverterLoad_PQ load3(V_start=120)
        annotation (Placement(transformation(extent={{36,-30},{16,-50}})));
      Modelica.Blocks.Math.Gain kW_to_W3(k=1000)
        annotation (Placement(transformation(extent={{-10,-38},{-4,-32}})));
      Modelica.Blocks.Math.Gain kvar_to_var3(k=1000)
        annotation (Placement(transformation(extent={{-10,-48},{-4,-42}})));
      Components.Controller.Model.Pv_Inv_VoltVarWatt_simple_Slim_weabus inv3(
        n=n,
        A=A,
        lat=lat,
        til=til,
        azi=azi,
        SMax=Smax/1000,
        QMaxInd=QIndmax/1000,
        QMaxCap=QCapmax/1000,
        thrP=thrP,
        hysP=hysP,
        thrQ=thrQ,
        hysQ=hysQ)
        annotation (Placement(transformation(extent={{-44,-50},{-24,-30}})));
      Buildings.Electrical.AC.OnePhase.Sensors.GeneralizedSensor sens1 annotation (
          Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=90,
            origin={48,30})));
      Buildings.Electrical.AC.OnePhase.Sensors.GeneralizedSensor sens3 annotation (
          Placement(transformation(
            extent={{10,-10},{-10,10}},
            rotation=90,
            origin={50,-30})));
      Buildings.Electrical.AC.OnePhase.Sensors.GeneralizedSensor sens2 annotation (
          Placement(transformation(
            extent={{10,-10},{-10,10}},
            rotation=0,
            origin={50,0})));
      Modelica.Blocks.Math.Gain vpu1(k=1/V_nominal)
        annotation (Placement(transformation(extent={{-72,36},{-64,44}})));
      Modelica.Blocks.Math.Gain vpu2(k=1/V_nominal)
        annotation (Placement(transformation(extent={{-72,-4},{-64,4}})));
      Modelica.Blocks.Math.Gain vpu3(k=1/V_nominal)
        annotation (Placement(transformation(extent={{-72,-44},{-64,-36}})));
      Modelica.Blocks.Sources.RealExpression activePower(y=sens1.S[1] + sens2.S[1]
             + sens3.S[1])
        annotation (Placement(transformation(extent={{-50,-106},{-90,-86}})));
      Modelica.Blocks.Sources.RealExpression reactivePower(y=sens1.S[2] + sens2.S[2]
             + sens3.S[2])
        annotation (Placement(transformation(extent={{-50,-92},{-90,-72}})));
      Modelica.Blocks.Sources.Constant const_voltage(k=0)
        annotation (Placement(transformation(extent={{-80,-70},{-90,-60}})));
      Modelica.Blocks.Math.Gain qctrl(k=1)
        annotation (Placement(transformation(extent={{-94,26},{-86,34}})));
      Modelica.Blocks.Math.Gain batt_ctrl(k=1)
        annotation (Placement(transformation(extent={{-94,0},{-86,8}})));
      Modelica.Blocks.Math.Gain plim(k=1)
        annotation (Placement(transformation(extent={{-94,14},{-86,22}})));
    equation
      connect(wye.terminal, terminal_p)
        annotation (Line(points={{90,0},{110,0}}, color={0,120,120}));
      connect(kW_to_W1.y, load1.Pow) annotation (Line(points={{-3.7,45},{6,45},{6,40},
              {14,40}}, color={0,0,127}));
      connect(kvar_to_var1.y, load1.Q)
        annotation (Line(points={{-3.7,35},{14,35},{14,34}},color={0,0,127}));
      connect(kW_to_W1.u, inv1.P)
        annotation (Line(points={{-10.6,45},{-23,45}},color={0,0,127}));
      connect(kvar_to_var1.u, inv1.Q)
        annotation (Line(points={{-10.6,35},{-23,35}},color={0,0,127}));
      connect(kW_to_W2.y, load2.Pow)
        annotation (Line(points={{-3.7,5},{6,5},{6,0},{14,0}},  color={0,0,127}));
      connect(kvar_to_var2.y, load2.Q)
        annotation (Line(points={{-3.7,-5},{14,-5},{14,-6}},color={0,0,127}));
      connect(kW_to_W2.u, inv2.P)
        annotation (Line(points={{-10.6,5},{-23,5}},color={0,0,127}));
      connect(kvar_to_var2.u, inv2.Q)
        annotation (Line(points={{-10.6,-5},{-23,-5}},color={0,0,127}));
      connect(kW_to_W3.y, load3.Pow) annotation (Line(points={{-3.7,-35},{6,-35},{6,
              -40},{14,-40}}, color={0,0,127}));
      connect(kvar_to_var3.y, load3.Q)
        annotation (Line(points={{-3.7,-45},{14,-45},{14,-46}},color={0,0,127}));
      connect(kW_to_W3.u, inv3.P)
        annotation (Line(points={{-10.6,-35},{-23,-35}},color={0,0,127}));
      connect(kvar_to_var3.u, inv3.Q)
        annotation (Line(points={{-10.6,-45},{-23,-45}},color={0,0,127}));
      connect(weaDatInpCon1.weaBus, inv1.weaBus) annotation (Line(
          points={{-70,80},{-60,80},{-60,47},{-44,47}},
          color={255,204,51},
          thickness=0.5));
      connect(inv2.weaBus, weaDatInpCon1.weaBus) annotation (Line(
          points={{-44,7},{-60,7},{-60,80},{-70,80}},
          color={255,204,51},
          thickness=0.5));
      connect(inv3.weaBus, weaDatInpCon1.weaBus) annotation (Line(
          points={{-44,-33},{-60,-33},{-60,80},{-70,80}},
          color={255,204,51},
          thickness=0.5));
      connect(sens2.terminal_p, load2.terminal)
        annotation (Line(points={{40,0},{36,0}}, color={0,120,120}));
      connect(load1.terminal, sens1.terminal_p)
        annotation (Line(points={{36,40},{48,40}}, color={0,120,120}));
      connect(load3.terminal, sens3.terminal_p)
        annotation (Line(points={{36,-40},{50,-40}}, color={0,120,120}));
      connect(sens2.terminal_n, wye.terminals[2]) annotation (Line(points={{60,0},{66,
              0},{66,0},{70.2,0}}, color={0,120,120}));
      connect(sens3.terminal_n, wye.terminals[3]) annotation (Line(points={{50,-20},
              {64,-20},{64,-0.533333},{70.2,-0.533333}}, color={0,120,120}));
      connect(sens1.terminal_n, wye.terminals[1]) annotation (Line(points={{48,20},{
              64,20},{64,0.533333},{70.2,0.533333}}, color={0,120,120}));
      connect(inv1.v, vpu1.y)
        annotation (Line(points={{-46,40},{-63.6,40}}, color={0,0,127}));
      connect(vpu3.y, inv3.v)
        annotation (Line(points={{-63.6,-40},{-46,-40}}, color={0,0,127}));
      connect(vpu2.y, inv2.v)
        annotation (Line(points={{-63.6,0},{-46,0}}, color={0,0,127}));
      connect(sens3.V, vpu3.u) annotation (Line(points={{59,-30},{64,-30},{64,-54},
              {-80,-54},{-80,-40},{-72.8,-40}}, color={0,0,127}));
      connect(sens2.V, vpu2.u) annotation (Line(points={{50,-9},{50,-12},{-80,-12},
              {-80,0},{-72.8,0}}, color={0,0,127}));
      connect(sens1.V, vpu1.u) annotation (Line(points={{57,30},{64,30},{64,60},{
              -80,60},{-80,40},{-72.8,40}}, color={0,0,127}));
      connect(const_voltage.y, invCtrlBus.v) annotation (Line(points={{-90.5,-65},{
              -99.9,-65},{-99.9,-19.9}}, color={0,0,127}), Text(
          string="%second",
          index=1,
          extent={{-6,3},{-6,3}},
          horizontalAlignment=TextAlignment.Right));
      connect(reactivePower.y, invCtrlBus.q) annotation (Line(points={{-92,-82},{
              -100,-82},{-100,-19.9},{-99.9,-19.9}}, color={0,0,127}), Text(
          string="%second",
          index=1,
          extent={{-6,3},{-6,3}},
          horizontalAlignment=TextAlignment.Right));
      connect(activePower.y, invCtrlBus.p) annotation (Line(points={{-92,-96},{
              -99.9,-96},{-99.9,-19.9}}, color={0,0,127}), Text(
          string="%second",
          index=1,
          extent={{-6,3},{-6,3}},
          horizontalAlignment=TextAlignment.Right));
      connect(batt_ctrl.u, invCtrlBus.batt_ctrl) annotation (Line(points={{-94.8,4},
              {-99.9,4},{-99.9,-19.9}}, color={0,0,127}), Text(
          string="%second",
          index=1,
          extent={{-6,3},{-6,3}},
          horizontalAlignment=TextAlignment.Right));
      connect(plim.u, invCtrlBus.plim) annotation (Line(points={{-94.8,18},{-99.9,
              18},{-99.9,-19.9}}, color={0,0,127}), Text(
          string="%second",
          index=1,
          extent={{-6,3},{-6,3}},
          horizontalAlignment=TextAlignment.Right));
      connect(qctrl.u, invCtrlBus.qctrl) annotation (Line(points={{-94.8,30},{-99.9,
              30},{-99.9,-19.9}}, color={0,0,127}), Text(
          string="%second",
          index=1,
          extent={{-6,3},{-6,3}},
          horizontalAlignment=TextAlignment.Right));
      annotation (Icon(coordinateSystem(preserveAspectRatio=false)),
      experiment(StartTime=2.09952e+07, StopTime=2.22039e+07),
      Diagram(coordinateSystem(preserveAspectRatio=false)));
    end generic_wye_voltvarwatt_simple;

    model IEEE13_PV_extBus_simple
      //parameter String weaName = "C:/Users/Christoph/Documents/SmartInverter/smartinverter_simulation/ExampleData/USA_CA_San.Francisco.Intl.AP.724940_TMY3_CONVERTED.mos" "Path to weather file";
      parameter String weaName = "/home/sim/Documents/smartinverter_simulation/ExampleData/USA_CA_San.Francisco.Intl.AP.724940_TMY3.mos" "Path to weather file";
      Components.Grid.Model.Network ieee13(redeclare
          Components.Grid.Records.IEEE_13 grid, V_nominal=4.16e3/sqrt(3))
        annotation (Placement(transformation(
            extent={{-10,10},{10,-10}},
            rotation=270,
            origin={0,90})));
      Components.Inverter.Model.SpotLoad_Y_PQ_extBus node3 annotation (Placement(
            transformation(
            extent={{-10,-10},{10,10}},
            rotation=90,
            origin={-50,50})));
      Components.Inverter.Model.SpotLoad_Y_PQ_extBus node4 annotation (Placement(
            transformation(
            extent={{-10,-10},{10,10}},
            rotation=90,
            origin={-90,50})));
      Components.Inverter.Model.SpotLoad_Y_PQ_extBus node2
        annotation (Placement(transformation(extent={{-30,20},{-10,40}})));
      Components.Inverter.Model.SpotLoad_Y_PQ_extBus node6 annotation (Placement(
            transformation(
            extent={{-10,-10},{10,10}},
            rotation=90,
            origin={70,50})));
      Components.Inverter.Model.SpotLoad_Y_PQ_extBus node11 annotation (Placement(
            transformation(
            extent={{-10,-10},{10,10}},
            rotation=90,
            origin={90,-10})));
      Components.Inverter.Model.SpotLoad_Y_PQ_extBus node10 annotation (Placement(
            transformation(
            extent={{-10,-10},{10,10}},
            rotation=90,
            origin={40,-16})));
      Components.Inverter.Model.SpotLoad_Y_PQ_extBus node7
        annotation (Placement(transformation(extent={{-30,-40},{-10,-20}})));
      Components.Inverter.Model.SpotLoad_Y_PQ_extBus node9 annotation (Placement(
            transformation(
            extent={{-10,-10},{10,10}},
            rotation=90,
            origin={-90,-10})));
      Components.Inverter.Model.SpotLoad_Y_PQ_extBus node12
        annotation (Placement(transformation(extent={{-60,-90},{-40,-70}})));
      Buildings.Electrical.AC.ThreePhasesUnbalanced.Sources.Grid node1(f=60, V=4.16e3)
        annotation (Placement(transformation(extent={{40,80},{60,100}})));
      Components.Inverter.Interfaces.LoadCtrlBus ctrlNode4 annotation (Placement(
            transformation(extent={{-110,4},{-90,24}}), iconTransformation(extent={{
                -140,6},{-120,26}})));
      Components.Inverter.Interfaces.LoadCtrlBus ctrlNode2 annotation (Placement(
            transformation(extent={{-110,24},{-90,44}}), iconTransformation(extent={
                {-140,6},{-120,26}})));
      Components.Inverter.Interfaces.LoadCtrlBus ctrlNode3 annotation (Placement(
            transformation(extent={{-110,14},{-90,34}}), iconTransformation(extent={
                {-140,6},{-120,26}})));
      Components.Inverter.Interfaces.LoadCtrlBus ctrlNode6 annotation (Placement(
            transformation(extent={{-110,-6},{-90,14}}), iconTransformation(extent={
                {-140,6},{-120,26}})));
      Components.Inverter.Interfaces.LoadCtrlBus ctrlNode7 annotation (Placement(
            transformation(extent={{-110,-50},{-90,-30}}), iconTransformation(
              extent={{-140,6},{-120,26}})));
      Components.Inverter.Interfaces.LoadCtrlBus ctrlNode9 annotation (Placement(
            transformation(extent={{-110,-40},{-90,-20}}), iconTransformation(
              extent={{-140,6},{-120,26}})));
      Components.Inverter.Interfaces.LoadCtrlBus ctrlNode10 annotation (Placement(
            transformation(extent={{-110,-60},{-90,-40}}), iconTransformation(
              extent={{-140,6},{-120,26}})));
      Components.Inverter.Interfaces.LoadCtrlBus ctrlNode11 annotation (Placement(
            transformation(extent={{-110,-70},{-90,-50}}), iconTransformation(
              extent={{-140,6},{-120,26}})));
      Components.Inverter.Interfaces.LoadCtrlBus ctrlNode12 annotation (Placement(
            transformation(extent={{-110,-80},{-90,-60}}), iconTransformation(
              extent={{-140,6},{-120,26}})));
      Components.Inverter.Model.SpotLoad_Y_PQ_extBus node13 annotation (Placement(transformation(extent={{-30,-90},
                {-10,-70}})));
      Components.Inverter.Interfaces.LoadCtrlBus ctrlNode13 annotation (Placement(
            transformation(extent={{-110,-90},{-90,-70}}), iconTransformation(
              extent={{-140,6},{-120,26}})));
      generic_wye_voltvarwatt_simple inverter13(weaName=weaName)
                                                                annotation (Placement(transformation(extent={{32,-90},
                {12,-70}})));
      generic_wye_voltvarwatt_simple inverter11(weaName=weaName)
                                                                annotation (Placement(transformation(
            extent={{10,-10},{-10,10}},
            rotation=90,
            origin={90,20})));
      generic_wye_voltvarwatt_simple inverter10(weaName=weaName) annotation (
          Placement(transformation(
            extent={{10,-10},{-10,10}},
            rotation=90,
            origin={40,20})));
      generic_wye_voltvarwatt_simple
                          inverter6(weaName=weaName)
                                    annotation (Placement(transformation(
            extent={{10,-10},{-10,10}},
            rotation=90,
            origin={90,80})));
      generic_wye_voltvarwatt_simple
                          inverter3(weaName=weaName)
                                    annotation (Placement(transformation(
            extent={{10,-10},{-10,10}},
            rotation=90,
            origin={-50,80})));
      Components.Inverter.Interfaces.InvCtrlBus ctrlInv3 annotation (Placement(
            transformation(extent={{-60,90},{-40,110}}), iconTransformation(extent={
                {-194,18},{-174,38}})));
      Components.Inverter.Interfaces.InvCtrlBus ctrlInv6 annotation (Placement(
            transformation(extent={{80,90},{100,110}}), iconTransformation(extent={{
                -194,18},{-174,38}})));
      Components.Inverter.Interfaces.InvCtrlBus ctrlInv10 annotation (Placement(
            transformation(extent={{90,44},{110,64}}), iconTransformation(extent={{
                -194,18},{-174,38}})));
      Components.Inverter.Interfaces.InvCtrlBus ctrlInv11 annotation (Placement(
            transformation(extent={{90,30},{110,50}}), iconTransformation(extent={{-194,
                18},{-174,38}})));
      Components.Inverter.Interfaces.InvCtrlBus ctrlInv13 annotation (Placement(
            transformation(extent={{40,-110},{60,-90}}), iconTransformation(extent={
                {-194,18},{-174,38}})));
    equation
      connect(node4.terminal_n, ieee13.terminal[4]) annotation (Line(points={{-90,60},
              {-90,62},{0,62},{0,80},{-1.77636e-15,80}},
                                                     color={0,120,120}));
      connect(node3.terminal_n, ieee13.terminal[3]) annotation (Line(points={{-50,
              60},{0,60},{0,80},{-1.77636e-015,80}}, color={0,120,120}));
      connect(node6.terminal_n, ieee13.terminal[6]) annotation (Line(points={{70,60},
              {0,60},{0,80}},         color={0,120,120}));
      connect(node2.terminal_n, ieee13.terminal[2])
        annotation (Line(points={{-10,30},{0,30},{0,80}},
                                                        color={0,120,120}));
      connect(node7.terminal_n, ieee13.terminal[7])
        annotation (Line(points={{-10,-30},{0,-30},{0,80}},
                                                          color={0,120,120}));
      connect(node9.terminal_n, ieee13.terminal[9]) annotation (Line(points={{-90,0},
              {-90,2},{0,2},{0,80},{-1.77636e-15,80}},
                                                color={0,120,120}));
      connect(node12.terminal_n, ieee13.terminal[12]) annotation (Line(points={{-40,-80},
              {-40,-80},{-40,0},{0,0},{0,80}},      color={0,120,120}));
      connect(node10.terminal_n, ieee13.terminal[10]) annotation (Line(points={{40,-6},
              {40,0},{0,0},{0,80},{-1.77636e-15,80}},
                                                   color={0,120,120}));
      connect(node11.terminal_n, ieee13.terminal[11])
        annotation (Line(points={{90,0},{90,2},{0,2},{0,80}},
                                                       color={0,120,120}));
      connect(node1.terminal, ieee13.terminal[1])
        annotation (Line(points={{50,80},{0,80}},           color={0,120,120}));
      connect(node12.ctrls, ctrlNode12) annotation (Line(
          points={{-60,-80},{-60,-80},{-70,-80},{-70,-70},{-100,-70}},
          color={255,204,51},
          thickness=0.5), Text(
          string="%second",
          index=1,
          extent={{6,3},{6,3}}));
      connect(ctrlNode11, node11.ctrls) annotation (Line(
          points={{-100,-60},{90,-60},{90,-20}},
          color={255,204,51},
          thickness=0.5), Text(
          string="%first",
          index=-1,
          extent={{-6,3},{-6,3}}));
      connect(ctrlNode10, node10.ctrls) annotation (Line(
          points={{-100,-50},{40,-50},{40,-26}},
          color={255,204,51},
          thickness=0.5), Text(
          string="%first",
          index=-1,
          extent={{-6,3},{-6,3}}));
      connect(node9.ctrls, ctrlNode9) annotation (Line(
          points={{-90,-20},{-90,-20},{-90,-30},{-100,-30}},
          color={255,204,51},
          thickness=0.5), Text(
          string="%second",
          index=1,
          extent={{6,3},{6,3}}));
      connect(ctrlNode7, node7.ctrls) annotation (Line(
          points={{-100,-40},{-60,-40},{-60,-30},{-30,-30}},
          color={255,204,51},
          thickness=0.5), Text(
          string="%first",
          index=-1,
          extent={{-6,3},{-6,3}}));
      connect(ctrlNode6, node6.ctrls) annotation (Line(
          points={{-100,4},{-80,4},{-80,14},{20,14},{20,40},{70,40}},
          color={255,204,51},
          thickness=0.5), Text(
          string="%first",
          index=-1,
          extent={{-6,3},{-6,3}}));
      connect(ctrlNode2, node2.ctrls) annotation (Line(
          points={{-100,34},{-60,34},{-60,30},{-30,30}},
          color={255,204,51},
          thickness=0.5), Text(
          string="%first",
          index=-1,
          extent={{-6,3},{-6,3}}));
      connect(ctrlNode3, node3.ctrls) annotation (Line(
          points={{-100,24},{-50,24},{-50,40},{-50,40}},
          color={255,204,51},
          thickness=0.5), Text(
          string="%first",
          index=-1,
          extent={{-6,3},{-6,3}}));
      connect(ctrlNode4, node4.ctrls) annotation (Line(
          points={{-100,14},{-90,14},{-90,40}},
          color={255,204,51},
          thickness=0.5), Text(
          string="%first",
          index=-1,
          extent={{-6,3},{-6,3}}));
      connect(node13.terminal_n, ieee13.terminal[13])
        annotation (Line(points={{-10,-80},{0,-80},{0,80}},
                                                         color={0,120,120}));
      connect(node13.ctrls, ctrlNode13) annotation (Line(
          points={{-30,-80},{-34,-80},{-34,-94},{-80,-94},{-80,-80},{-100,-80}},
          color={255,204,51},
          thickness=0.5), Text(
          string="%second",
          index=1,
          extent={{6,3},{6,3}}));
      connect(inverter6.terminal_p, ieee13.terminal[6])
        annotation (Line(points={{90,69},{90,62},{0,62},{0,80},{-1.77636e-15,80}},
                                                   color={0,120,120}));
      connect(inverter3.terminal_p, ieee13.terminal[3])
        annotation (Line(points={{-50,69},{-50,70},{0,70},{0,76},{-1.77636e-15,76},
              {-1.77636e-15,80}},                    color={0,120,120}));
      connect(inverter3.invCtrlBus, ctrlInv3) annotation (Line(
          points={{-50,90},{-50,100}},
          color={255,204,51},
          thickness=0.5), Text(
          string="%second",
          index=1,
          extent={{-3,6},{-3,6}},
          horizontalAlignment=TextAlignment.Right));
      connect(inverter6.invCtrlBus, ctrlInv6) annotation (Line(
          points={{90,90},{90,100}},
          color={255,204,51},
          thickness=0.5), Text(
          string="%second",
          index=1,
          extent={{-3,6},{-3,6}},
          horizontalAlignment=TextAlignment.Right));
      connect(inverter11.invCtrlBus, ctrlInv11) annotation (Line(
          points={{90,30},{96,30},{96,40},{100,40}},
          color={255,204,51},
          thickness=0.5), Text(
          string="%second",
          index=1,
          extent={{6,3},{6,3}},
          horizontalAlignment=TextAlignment.Left));
      connect(inverter13.invCtrlBus, ctrlInv13) annotation (Line(
          points={{32,-80},{50,-80},{50,-100}},
          color={255,204,51},
          thickness=0.5), Text(
          string="%second",
          index=1,
          extent={{6,3},{6,3}},
          horizontalAlignment=TextAlignment.Left));
      connect(inverter11.terminal_p, ieee13.terminal[11])
        annotation (Line(points={{90,9},{90,4},{0,4},{0,80},{-1.77636e-15,80}},
                                                  color={0,120,120}));
      connect(inverter13.terminal_p, ieee13.terminal[13])
        annotation (Line(points={{11,-80},{0,-80},{0,80}},
                                                    color={0,120,120}));
      connect(ieee13.terminal[10], inverter10.terminal_p)
        annotation (Line(points={{0,80},{0,6},{40,6},{40,9}}, color={0,120,120}));
      connect(ctrlInv10, inverter10.invCtrlBus) annotation (Line(
          points={{100,54},{88,54},{88,36},{40,36},{40,30}},
          color={255,204,51},
          thickness=0.5), Text(
          string="%first",
          index=-1,
          extent={{-3,6},{-3,6}},
          horizontalAlignment=TextAlignment.Right));
      annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
            coordinateSystem(preserveAspectRatio=false)));
    end IEEE13_PV_extBus_simple;

    model IEEE13_PV_extBus_simple_oldinv9
      //parameter String weaName = "C:/Users/Christoph/Documents/SmartInverter/smartinverter_simulation/ExampleData/USA_CA_San.Francisco.Intl.AP.724940_TMY3_CONVERTED.mos" "Path to weather file";
      parameter String weaName = "/home/sim/Documents/smartinverter_simulation/ExampleData/USA_CA_San.Francisco.Intl.AP.724940_TMY3.mos" "Path to weather file";
      Components.Grid.Model.Network ieee13(redeclare
          Components.Grid.Records.IEEE_13 grid, V_nominal=4.16e3/sqrt(3))
        annotation (Placement(transformation(
            extent={{-10,10},{10,-10}},
            rotation=270,
            origin={0,90})));
      Components.Inverter.Model.SpotLoad_Y_PQ_extBus node3 annotation (Placement(
            transformation(
            extent={{-10,-10},{10,10}},
            rotation=90,
            origin={-50,50})));
      Components.Inverter.Model.SpotLoad_Y_PQ_extBus node4 annotation (Placement(
            transformation(
            extent={{-10,-10},{10,10}},
            rotation=90,
            origin={-90,50})));
      Components.Inverter.Model.SpotLoad_Y_PQ_extBus node2
        annotation (Placement(transformation(extent={{-20,20},{0,40}})));
      Components.Inverter.Model.SpotLoad_Y_PQ_extBus node6 annotation (Placement(
            transformation(
            extent={{-10,-10},{10,10}},
            rotation=90,
            origin={70,46})));
      Components.Inverter.Model.SpotLoad_Y_PQ_extBus node11 annotation (Placement(
            transformation(
            extent={{-10,-10},{10,10}},
            rotation=90,
            origin={90,-10})));
      Components.Inverter.Model.SpotLoad_Y_PQ_extBus node10 annotation (Placement(
            transformation(
            extent={{-10,-10},{10,10}},
            rotation=90,
            origin={42,-16})));
      Components.Inverter.Model.SpotLoad_Y_PQ_extBus node7
        annotation (Placement(transformation(extent={{-20,-40},{0,-20}})));
      Components.Inverter.Model.SpotLoad_Y_PQ_extBus node9 annotation (Placement(
            transformation(
            extent={{-10,-10},{10,10}},
            rotation=90,
            origin={-90,-10})));
      Components.Inverter.Model.SpotLoad_Y_PQ_extBus node12
        annotation (Placement(transformation(extent={{-60,-90},{-40,-70}})));
      Buildings.Electrical.AC.ThreePhasesUnbalanced.Sources.Grid node1(f=60, V=4.16e3)
        annotation (Placement(transformation(extent={{40,80},{60,100}})));
      Components.Inverter.Interfaces.LoadCtrlBus ctrlNode4 annotation (Placement(
            transformation(extent={{-110,4},{-90,24}}), iconTransformation(extent={{
                -140,6},{-120,26}})));
      Components.Inverter.Interfaces.LoadCtrlBus ctrlNode2 annotation (Placement(
            transformation(extent={{-110,24},{-90,44}}), iconTransformation(extent={
                {-140,6},{-120,26}})));
      Components.Inverter.Interfaces.LoadCtrlBus ctrlNode3 annotation (Placement(
            transformation(extent={{-110,14},{-90,34}}), iconTransformation(extent={
                {-140,6},{-120,26}})));
      Components.Inverter.Interfaces.LoadCtrlBus ctrlNode6 annotation (Placement(
            transformation(extent={{-110,-6},{-90,14}}), iconTransformation(extent={
                {-140,6},{-120,26}})));
      Components.Inverter.Interfaces.LoadCtrlBus ctrlNode7 annotation (Placement(
            transformation(extent={{-110,-50},{-90,-30}}), iconTransformation(
              extent={{-140,6},{-120,26}})));
      Components.Inverter.Interfaces.LoadCtrlBus ctrlNode9 annotation (Placement(
            transformation(extent={{-110,-40},{-90,-20}}), iconTransformation(
              extent={{-140,6},{-120,26}})));
      Components.Inverter.Interfaces.LoadCtrlBus ctrlNode10 annotation (Placement(
            transformation(extent={{-110,-60},{-90,-40}}), iconTransformation(
              extent={{-140,6},{-120,26}})));
      Components.Inverter.Interfaces.LoadCtrlBus ctrlNode11 annotation (Placement(
            transformation(extent={{-110,-70},{-90,-50}}), iconTransformation(
              extent={{-140,6},{-120,26}})));
      Components.Inverter.Interfaces.LoadCtrlBus ctrlNode12 annotation (Placement(
            transformation(extent={{-110,-80},{-90,-60}}), iconTransformation(
              extent={{-140,6},{-120,26}})));
      Components.Inverter.Model.SpotLoad_Y_PQ_extBus node13 annotation (Placement(transformation(extent={{-20,-90},{0,-70}})));
      Components.Inverter.Interfaces.LoadCtrlBus ctrlNode13 annotation (Placement(
            transformation(extent={{-110,-90},{-90,-70}}), iconTransformation(
              extent={{-140,6},{-120,26}})));
      generic_wye_voltvarwatt_simple inverter13(weaName=weaName)
                                                                annotation (Placement(transformation(extent={{32,-90},{12,-70}})));
      generic_wye_voltvarwatt_simple inverter11(weaName=weaName)
                                                                annotation (Placement(transformation(
            extent={{10,-10},{-10,10}},
            rotation=90,
            origin={90,16})));
      generic_wye_voltvarwatt_simple inverter9(weaName=weaName)
                                                               annotation (Placement(
            transformation(
            extent={{10,-10},{-10,10}},
            rotation=90,
            origin={-74,18})));
      generic_wye_voltvarwatt_simple
                          inverter6(weaName=weaName)
                                    annotation (Placement(transformation(
            extent={{10,-10},{-10,10}},
            rotation=90,
            origin={90,78})));
      generic_wye_voltvarwatt_simple
                          inverter3(weaName=weaName)
                                    annotation (Placement(transformation(
            extent={{10,-10},{-10,10}},
            rotation=90,
            origin={-50,78})));
      Components.Inverter.Interfaces.InvCtrlBus ctrlInv3 annotation (Placement(
            transformation(extent={{-60,90},{-40,110}}), iconTransformation(extent={
                {-194,18},{-174,38}})));
      Components.Inverter.Interfaces.InvCtrlBus ctrlInv6 annotation (Placement(
            transformation(extent={{80,90},{100,110}}), iconTransformation(extent={{
                -194,18},{-174,38}})));
      Components.Inverter.Interfaces.InvCtrlBus ctrlInv9 annotation (Placement(
            transformation(extent={{-58,8},{-38,28}}), iconTransformation(extent={{-194,
                18},{-174,38}})));
      Components.Inverter.Interfaces.InvCtrlBus ctrlInv11 annotation (Placement(
            transformation(extent={{92,10},{112,30}}), iconTransformation(extent={{-194,
                18},{-174,38}})));
      Components.Inverter.Interfaces.InvCtrlBus ctrlInv13 annotation (Placement(
            transformation(extent={{20,-110},{40,-90}}), iconTransformation(extent={
                {-194,18},{-174,38}})));
    equation
      connect(node4.terminal_n, ieee13.terminal[4]) annotation (Line(points={{-90,60},
              {0,60},{0,80},{-1.77636e-015,80}},     color={0,120,120}));
      connect(node3.terminal_n, ieee13.terminal[3]) annotation (Line(points={{-50,
              60},{0,60},{0,80},{-1.77636e-015,80}}, color={0,120,120}));
      connect(node6.terminal_n, ieee13.terminal[6]) annotation (Line(points={{70,56},
              {0,56},{0,80}},         color={0,120,120}));
      connect(node2.terminal_n, ieee13.terminal[2])
        annotation (Line(points={{0,30},{0,30},{0,80}}, color={0,120,120}));
      connect(node7.terminal_n, ieee13.terminal[7])
        annotation (Line(points={{0,-30},{0,-30},{0,80}}, color={0,120,120}));
      connect(node9.terminal_n, ieee13.terminal[9]) annotation (Line(points={{-90,0},
              {0,0},{0,80},{-1.77636e-015,80}}, color={0,120,120}));
      connect(node12.terminal_n, ieee13.terminal[12]) annotation (Line(points={{-40,-80},
              {-40,-80},{-40,0},{0,0},{0,80}},      color={0,120,120}));
      connect(node10.terminal_n, ieee13.terminal[10]) annotation (Line(points={{42,-6},
              {0,-6},{0,80},{-1.77636e-15,80}},    color={0,120,120}));
      connect(node11.terminal_n, ieee13.terminal[11])
        annotation (Line(points={{90,0},{0,0},{0,80}}, color={0,120,120}));
      connect(node1.terminal, ieee13.terminal[1])
        annotation (Line(points={{50,80},{0,80}},           color={0,120,120}));
      connect(node12.ctrls, ctrlNode12) annotation (Line(
          points={{-60,-80},{-60,-80},{-70,-80},{-70,-70},{-100,-70}},
          color={255,204,51},
          thickness=0.5), Text(
          string="%second",
          index=1,
          extent={{6,3},{6,3}}));
      connect(ctrlNode11, node11.ctrls) annotation (Line(
          points={{-100,-60},{90,-60},{90,-20}},
          color={255,204,51},
          thickness=0.5), Text(
          string="%first",
          index=-1,
          extent={{-6,3},{-6,3}}));
      connect(ctrlNode10, node10.ctrls) annotation (Line(
          points={{-100,-50},{42,-50},{42,-26}},
          color={255,204,51},
          thickness=0.5), Text(
          string="%first",
          index=-1,
          extent={{-6,3},{-6,3}}));
      connect(node9.ctrls, ctrlNode9) annotation (Line(
          points={{-90,-20},{-90,-20},{-90,-30},{-100,-30}},
          color={255,204,51},
          thickness=0.5), Text(
          string="%second",
          index=1,
          extent={{6,3},{6,3}}));
      connect(ctrlNode7, node7.ctrls) annotation (Line(
          points={{-100,-40},{-60,-40},{-60,-30},{-20,-30}},
          color={255,204,51},
          thickness=0.5), Text(
          string="%first",
          index=-1,
          extent={{-6,3},{-6,3}}));
      connect(ctrlNode6, node6.ctrls) annotation (Line(
          points={{-100,4},{20,4},{20,36},{70,36}},
          color={255,204,51},
          thickness=0.5), Text(
          string="%first",
          index=-1,
          extent={{-6,3},{-6,3}}));
      connect(ctrlNode2, node2.ctrls) annotation (Line(
          points={{-100,34},{-60,34},{-60,30},{-20,30}},
          color={255,204,51},
          thickness=0.5), Text(
          string="%first",
          index=-1,
          extent={{-6,3},{-6,3}}));
      connect(ctrlNode3, node3.ctrls) annotation (Line(
          points={{-100,24},{-50,24},{-50,40},{-50,40}},
          color={255,204,51},
          thickness=0.5), Text(
          string="%first",
          index=-1,
          extent={{-6,3},{-6,3}}));
      connect(ctrlNode4, node4.ctrls) annotation (Line(
          points={{-100,14},{-90,14},{-90,40}},
          color={255,204,51},
          thickness=0.5), Text(
          string="%first",
          index=-1,
          extent={{-6,3},{-6,3}}));
      connect(node13.terminal_n, ieee13.terminal[13])
        annotation (Line(points={{0,-80},{0,80},{0,80}}, color={0,120,120}));
      connect(node13.ctrls, ctrlNode13) annotation (Line(
          points={{-20,-80},{-28,-80},{-28,-94},{-80,-94},{-80,-80},{-100,-80}},
          color={255,204,51},
          thickness=0.5), Text(
          string="%second",
          index=1,
          extent={{6,3},{6,3}}));
      connect(inverter9.terminal_p, ieee13.terminal[9])
        annotation (Line(points={{-74,7},{8,7},{8,80},{0,80}}, color={0,120,120}));
      connect(inverter6.terminal_p, ieee13.terminal[6])
        annotation (Line(points={{90,67},{90,69},{2,69},{2,80},{-1.77636e-15,80}},
                                                   color={0,120,120}));
      connect(inverter3.terminal_p, ieee13.terminal[3])
        annotation (Line(points={{-50,67},{-50,70},{-1.77636e-15,70},{-1.77636e-15,80}},
                                                     color={0,120,120}));
      connect(inverter3.invCtrlBus, ctrlInv3) annotation (Line(
          points={{-50,88},{-50,100}},
          color={255,204,51},
          thickness=0.5), Text(
          string="%second",
          index=1,
          extent={{-3,6},{-3,6}},
          horizontalAlignment=TextAlignment.Right));
      connect(inverter6.invCtrlBus, ctrlInv6) annotation (Line(
          points={{90,88},{90,100}},
          color={255,204,51},
          thickness=0.5), Text(
          string="%second",
          index=1,
          extent={{-3,6},{-3,6}},
          horizontalAlignment=TextAlignment.Right));
      connect(inverter11.invCtrlBus, ctrlInv11) annotation (Line(
          points={{90,26},{96,26},{96,20},{102,20}},
          color={255,204,51},
          thickness=0.5), Text(
          string="%second",
          index=1,
          extent={{6,3},{6,3}},
          horizontalAlignment=TextAlignment.Left));
      connect(inverter13.invCtrlBus, ctrlInv13) annotation (Line(
          points={{32,-80},{26,-80},{26,-100},{30,-100}},
          color={255,204,51},
          thickness=0.5), Text(
          string="%second",
          index=1,
          extent={{6,3},{6,3}},
          horizontalAlignment=TextAlignment.Left));
      connect(inverter11.terminal_p, ieee13.terminal[11])
        annotation (Line(points={{90,5},{90,4},{56,4},{56,80},{-1.77636e-15,80}},
                                                  color={0,120,120}));
      connect(inverter13.terminal_p, ieee13.terminal[13])
        annotation (Line(points={{11,-80},{6,-80},{6,80},{0,80}},
                                                    color={0,120,120}));
      connect(inverter9.invCtrlBus, ctrlInv9) annotation (Line(
          points={{-74,28},{-62,28},{-62,18},{-48,18}},
          color={255,204,51},
          thickness=0.5), Text(
          string="%second",
          index=1,
          extent={{6,3},{6,3}}));
      annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
            coordinateSystem(preserveAspectRatio=false)));
    end IEEE13_PV_extBus_simple_oldinv9;
  end Systems;

  package Dynamic
    package Sensor
      package Model
        model fft
           Modelica.Blocks.Interfaces.RealInput u annotation (Placement(transformation(
                extent={{-20,-20},{20,20}},
                origin={-120,0}),iconTransformation(
                extent={{-20,-20},{20,20}},
                origin={-120,0})));

           Modelica.Blocks.Interfaces.RealOutput info "Information flag from FFT computation; = 0: FFT successfully computed"
           annotation (Placement(transformation(
                extent={{-10,-10},{10,10}},
                origin={0,-110},
                rotation=-90),   iconTransformation(
                extent={{-10,-10},{10,10}},
                origin={0,-110},
                rotation=-90)));
           Modelica.Blocks.Interfaces.RealOutput amplitude
            "FFT amplitude of interested frequency band"                                                annotation (Placement(transformation(
                extent={{-10,-10},{10,10}},
                origin={110,50}),iconTransformation(
                extent={{-10,-10},{10,10}},
                origin={110,50})));
           Modelica.Blocks.Interfaces.RealOutput phase
            "FFT phase of interested frequency band"                                            annotation (Placement(transformation(
                extent={{-10,-10},{10,10}},
                origin={110,-50}),
                                 iconTransformation(
                extent={{-10,-10},{10,10}},
                origin={110,-50})));

          parameter Modelica.SIunits.Frequency f_max = 1000
            "Maximum frequency of interest";
          parameter Modelica.SIunits.Frequency f_res = 60
            "Frequency resolution";
          parameter Integer n_out = 2 "Frequency bracket output [f_res*(nout-1) : f_res*nout]";

          //output Integer inf0(final start=0, final fixed=true)
          //  "Information flag from FFT computation; = 0: FFT successfully computed";
          output Real Ai[nfi](each start=0, each fixed=true)
            "FFT amplitudes of interested frequency points";
          output Real ph[nfi](each start=0, each fixed=true, unit="deg")
            "FFT phases of interested frequency points in [deg]";

        protected
          Integer iTick(start=0, fixed=true);
          Real y_buf[ns](each start=0, each fixed=true);
          parameter Integer ns = Modelica.Math.FastFourierTransform.realFFTsamplePoints(f_max, f_res, f_max_factor=5);
          //parameter Integer ns = integer(100);
          parameter Modelica.SIunits.Frequency f_max_FFT = f_res*div(ns, 2)
            "Maximum frequency used by FFT";
          parameter Integer nf = div(ns,2) + 1 "Number of frequency points";
          parameter Modelica.SIunits.Time Ts = 1/(2*f_max_FFT) "Sample period";
          parameter Integer nfi = max(1,min(integer(ceil(f_max/f_res))+1,nf))
            "Number of frequency points of the interested frequency range (only up to f_max)";

        algorithm
          when sample(0,Ts) then
             iTick :=pre(iTick) + 1;
             if iTick >= 1 and iTick <= ns then
                y_buf[iTick] :=u;
             end if;

             if iTick == ns then
               (info, Ai, ph) :=Modelica.Math.FastFourierTransform.realFFT(y_buf, nfi);
               iTick :=0;
             end if;
          end when;
          amplitude := Ai[n_out];
          phase := ph[n_out];
          annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
                coordinateSystem(preserveAspectRatio=false)));
        end fft;

        model dynToPh
          Modelica.Electrical.Analog.Interfaces.PositivePin p_i
            annotation (Placement(transformation(extent={{-110,-10},{-90,10}})));
          Modelica.Electrical.Analog.Interfaces.NegativePin n_i
            annotation (Placement(transformation(extent={{110,-10},{90,10}})));
          fft fft_v(
            f_max=f_max,
            f_res=f_res,
            n_out=n_out)
                    annotation (Placement(transformation(extent={{40,40},{60,60}})));
          Modelica.Blocks.Sources.RealExpression Voltage(y=p_v.v)
            annotation (Placement(transformation(extent={{0,40},{20,60}})));
          Modelica.Blocks.Sources.RealExpression Current(y=p_i.i)
            annotation (Placement(transformation(extent={{0,-60},{20,-40}})));
          fft fft_i(
            f_max=f_max,
            f_res=f_res,
            n_out=n_out)
                    annotation (Placement(transformation(extent={{40,-60},{60,-40}})));
           Modelica.Blocks.Interfaces.RealOutput v_amplitude
            "FFT amplitude of interested frequency band" annotation (Placement(
                transformation(extent={{-10,-10},{10,10}}, origin={110,70}),
                iconTransformation(
                extent={{-10,-10},{10,10}},
                origin={-70,-110},
                rotation=-90)));
           Modelica.Blocks.Interfaces.RealOutput v_phase
            "FFT phase of interested frequency band" annotation (Placement(
                transformation(extent={{-10,-10},{10,10}}, origin={110,30}),
                iconTransformation(
                extent={{-10,-10},{10,10}},
                origin={30,-110},
                rotation=-90)));
           Modelica.Blocks.Interfaces.RealOutput i_amplitude
            "FFT amplitude of interested frequency band" annotation (Placement(
                transformation(extent={{-10,-10},{10,10}}, origin={110,-30}),
                iconTransformation(
                extent={{-10,-10},{10,10}},
                origin={-30,-110},
                rotation=-90)));
           Modelica.Blocks.Interfaces.RealOutput i_phase
            "FFT phase of interested frequency band" annotation (Placement(
                transformation(extent={{-10,-10},{10,10}}, origin={110,-70}),
                iconTransformation(
                extent={{-10,-10},{10,10}},
                origin={70,-110},
                rotation=-90)));
          Modelica.Electrical.Analog.Interfaces.PositivePin p_v
            annotation (Placement(transformation(extent={{-10,90},{10,110}})));
          Modelica.Electrical.Analog.Sensors.VoltageSensor voltageSensor annotation (
              Placement(transformation(
                extent={{-10,-10},{10,10}},
                rotation=-90,
                origin={-40,30})));
          Modelica.Electrical.Analog.Sensors.CurrentSensor currentSensor
            annotation (Placement(transformation(extent={{-80,-10},{-60,10}})));

          parameter Modelica.SIunits.Frequency f_max = 1000
            "Maximum frequency of interest";
          parameter Modelica.SIunits.Frequency f_res = 60
            "Frequency resolution";
          parameter Integer n_out = 2 "Frequency bracket output [f_res*(nout-1) : f_res*nout]";

        equation
          connect(Voltage.y, fft_v.u)
            annotation (Line(points={{21,50},{38,50}}, color={0,0,127}));
          connect(Current.y, fft_i.u)
            annotation (Line(points={{21,-50},{38,-50}}, color={0,0,127}));
          connect(fft_v.amplitude, v_amplitude) annotation (Line(points={{61,55},{80,55},
                  {80,70},{110,70}}, color={0,0,127}));
          connect(fft_v.phase, v_phase) annotation (Line(points={{61,45},{80,45},{80,30},
                  {110,30}}, color={0,0,127}));
          connect(fft_i.amplitude, i_amplitude) annotation (Line(points={{61,-45},{80,-45},
                  {80,-30},{110,-30}}, color={0,0,127}));
          connect(fft_i.phase, i_phase) annotation (Line(points={{61,-55},{80,-55},{80,-70},
                  {110,-70}}, color={0,0,127}));
          connect(n_i, currentSensor.n)
            annotation (Line(points={{100,0},{-60,0}}, color={0,0,255}));
          connect(currentSensor.p, p_i)
            annotation (Line(points={{-80,0},{-100,0}}, color={0,0,255}));
          connect(voltageSensor.n, n_i)
            annotation (Line(points={{-40,20},{-40,0},{100,0}}, color={0,0,255}));
          connect(voltageSensor.p, p_v) annotation (Line(points={{-40,40},{-40,80},{0,80},
                  {0,100}}, color={0,0,255}));
          annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
                coordinateSystem(preserveAspectRatio=false)));
        end dynToPh;

        model dynToPQ
          Modelica.Electrical.Analog.Interfaces.PositivePin p_i
            annotation (Placement(transformation(extent={{-110,-10},{-90,10}})));
          Modelica.Electrical.Analog.Interfaces.NegativePin n_i
            annotation (Placement(transformation(extent={{110,-10},{90,10}})));
          Modelica.Electrical.Analog.Interfaces.PositivePin p_v
            annotation (Placement(transformation(extent={{-10,90},{10,110}})));

          parameter Modelica.SIunits.Frequency f_max = 1000
            "Maximum frequency of interest";
          parameter Modelica.SIunits.Frequency f_res = 60
            "Frequency resolution";
          parameter Integer n_out = 2 "Frequency bracket output [f_res*(nout-1) : f_res*nout]";
          Real vrms;
          Real irms;

          dynToPh dynToPh1(
            f_max=f_max,
            f_res=f_res,
            n_out=n_out)
            annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
          Modelica.Blocks.Interfaces.RealOutput q(unit="var") "Reactive power"
            annotation (Placement(
                transformation(extent={{-10,-10},{10,10}},
                rotation=-90,
                origin={-30,-110})));
          Modelica.Blocks.Interfaces.RealOutput p(unit="W") "Active power"
            annotation (Placement(transformation(extent={{-10,-10},{10,10}},
                rotation=-90,
                origin={-70,-110})));
        equation
          vrms = dynToPh1.v_amplitude / sqrt(2);
          irms = dynToPh1.i_amplitude / sqrt(2);
          p = vrms*irms*cos(Modelica.SIunits.Conversions.from_deg(dynToPh1.v_phase-dynToPh1.i_phase));
          q = vrms*irms*sin(Modelica.SIunits.Conversions.from_deg(dynToPh1.v_phase-dynToPh1.i_phase));
          connect(dynToPh1.p_i, p_i)
            annotation (Line(points={{-10,0},{-100,0}}, color={0,0,255}));
          connect(dynToPh1.n_i, n_i)
            annotation (Line(points={{10,0},{100,0}}, color={0,0,255}));
          connect(dynToPh1.p_v, p_v)
            annotation (Line(points={{0,10},{0,100}}, color={0,0,255}));
          annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
                coordinateSystem(preserveAspectRatio=false)));
        end dynToPQ;
      end Model;

      package Examples
        model Test_dynToX
          Modelica.Electrical.Analog.Sources.SineVoltage SineVoltage(V=120, freqHz=60)
            annotation (Placement(transformation(
                extent={{-10,-10},{10,10}},
                rotation=-90,
                origin={90,10})));
          Modelica.Electrical.Analog.Basic.Ground ground1
            annotation (Placement(transformation(extent={{80,-20},{100,0}})));
          Modelica.Electrical.Analog.Basic.VariableResistor variableResistor
            annotation (Placement(transformation(
                extent={{-10,10},{10,-10}},
                rotation=-90,
                origin={-60,10})));
          Modelica.Blocks.Sources.Ramp ramp_R(
            duration=1,
            startTime=1,
            offset=10,
            height=-8.5) annotation (Placement(transformation(
                extent={{-10,-10},{10,10}},
                rotation=90,
                origin={-80,-30})));
          Model.dynToPh dynToPh
            annotation (Placement(transformation(extent={{0,-10},{20,10}})));
          Model.dynToPQ dynToPQ
            annotation (Placement(transformation(extent={{40,-10},{60,10}})));
          Modelica.Electrical.Analog.Basic.VariableInductor variableInductor
            annotation (Placement(transformation(
                extent={{-10,10},{10,-10}},
                rotation=-90,
                origin={-20,10})));
          Modelica.Blocks.Sources.Ramp ramp_L(
            duration=1,
            startTime=3,
            offset=0.1,
            height=-0.09) annotation (Placement(transformation(
                extent={{-10,-10},{10,10}},
                rotation=90,
                origin={-40,-30})));
        equation
          connect(dynToPh.p_v, SineVoltage.p)
            annotation (Line(points={{10,10},{10,20},{90,20}}, color={0,0,255}));
          connect(SineVoltage.n, ground1.p)
            annotation (Line(points={{90,0},{90,0}}, color={0,0,255}));
          connect(dynToPh.n_i, dynToPQ.p_i)
            annotation (Line(points={{20,0},{40,0}}, color={0,0,255}));
          connect(dynToPQ.n_i, SineVoltage.n)
            annotation (Line(points={{60,0},{90,0}}, color={0,0,255}));
          connect(dynToPQ.p_v, SineVoltage.p)
            annotation (Line(points={{50,10},{50,20},{90,20}}, color={0,0,255}));
          connect(variableInductor.L, ramp_L.y)
            annotation (Line(points={{-30.8,10},{-40,10},{-40,-19}}, color={0,0,127}));
          connect(ramp_R.y, variableResistor.R)
            annotation (Line(points={{-80,-19},{-80,10},{-71,10}}, color={0,0,127}));
          connect(variableInductor.p, SineVoltage.p)
            annotation (Line(points={{-20,20},{90,20}}, color={0,0,255}));
          connect(variableResistor.p, SineVoltage.p)
            annotation (Line(points={{-60,20},{90,20}}, color={0,0,255}));
          connect(variableInductor.n, dynToPh.p_i)
            annotation (Line(points={{-20,0},{0,0}}, color={0,0,255}));
          connect(variableResistor.n, dynToPh.p_i) annotation (Line(points={{-60,
                  3.55271e-15},{-30,3.55271e-15},{-30,0},{0,0}}, color={0,0,255}));
          annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
                coordinateSystem(preserveAspectRatio=false)));
        end Test_dynToX;
      end Examples;
    end Sensor;

    package Interfacing
      package Model

        model Interface_MBL
          Modelica.Electrical.Analog.Interfaces.PositivePin p_i
            annotation (Placement(transformation(extent={{-110,-10},{-90,10}})));
          Modelica.Electrical.Analog.Interfaces.NegativePin n_i
            annotation (Placement(transformation(extent={{110,-10},{90,10}})));
          Modelica.Electrical.Analog.Interfaces.PositivePin p_v
            annotation (Placement(transformation(extent={{-10,90},{10,110}})));

          parameter Modelica.SIunits.Frequency f_max = 1000
            "Maximum frequency of interest";
          parameter Modelica.SIunits.Frequency f_res = 60
            "Frequency resolution";
          parameter Integer n_out = 2 "Frequency bracket output [f_res*(nout-1) : f_res*nout]";

          Sensor.Model.dynToPQ dynToPQ(
            f_max=f_max,
            f_res=f_res,
            n_out=n_out)
            annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
          Components.Inverter.Model.InverterLoad_PQ inverterLoad_PQ annotation (
              Placement(transformation(
                extent={{10,-10},{-10,10}},
                rotation=-90,
                origin={0,-60})));
          Buildings.Electrical.AC.OnePhase.Interfaces.Terminal_n term_n annotation (
              Placement(transformation(
                extent={{-10,-10},{10,10}},
                rotation=-90,
                origin={0,-110})));
        equation

          connect(dynToPQ.p_i, p_i)
            annotation (Line(points={{-10,0},{-100,0}}, color={0,0,255}));
          connect(dynToPQ.n_i, n_i)
            annotation (Line(points={{10,0},{100,0}}, color={0,0,255}));
          connect(dynToPQ.p_v, p_v)
            annotation (Line(points={{0,10},{0,100}}, color={0,0,255}));
          connect(dynToPQ.q, inverterLoad_PQ.Q) annotation (Line(points={{-3,-11},{-3,-32},
                  {6,-32},{6,-48}}, color={0,0,127}));
          connect(dynToPQ.p, inverterLoad_PQ.Pow) annotation (Line(points={{-7,-11},{-7,
                  -36},{1.9984e-15,-36},{1.9984e-15,-48}}, color={0,0,127}));
          connect(inverterLoad_PQ.terminal, term_n)
            annotation (Line(points={{0,-70},{0,-110}}, color={0,120,120}));
          annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
                coordinateSystem(preserveAspectRatio=false)));
        end Interface_MBL;
      end Model;

      package Examples
        model Test_MBL
          Buildings.Electrical.AC.OnePhase.Sources.FixedVoltage fixVol(f=60, V=120)
            annotation (Placement(transformation(extent={{-40,-50},{-20,-30}})));
          Buildings.Electrical.AC.OnePhase.Sources.PVSimple pv(A=1)
            annotation (Placement(transformation(extent={{80,-50},{100,-30}})));
          Modelica.Blocks.Sources.Constant const(k=1000)
            annotation (Placement(transformation(extent={{60,-20},{80,0}})));
          Buildings.Electrical.AC.OnePhase.Sensors.Probe sens(V_nominal=120,
              perUnit=false)
            annotation (Placement(transformation(extent={{30,-30},{10,-10}})));
          Buildings.Electrical.AC.OnePhase.Sensors.GeneralizedSensor sens2
            annotation (Placement(transformation(extent={{-10,-50},{10,-30}})));
          Modelica.Electrical.Analog.Basic.Ground ground1
            annotation (Placement(transformation(extent={{30,40},{50,60}})));
          Modelica.Electrical.Analog.Basic.VariableResistor variableResistor
            annotation (Placement(transformation(
                extent={{-10,10},{10,-10}},
                rotation=-90,
                origin={-60,70})));
          Modelica.Blocks.Sources.Ramp ramp_R(
            duration=1,
            startTime=1,
            offset=10,
            height=-8.5) annotation (Placement(transformation(
                extent={{-10,-10},{10,10}},
                rotation=90,
                origin={-80,30})));
          Model.Interface_MBL interface_MBL1
            annotation (Placement(transformation(extent={{0,50},{20,70}})));
          Modelica.Electrical.Analog.Basic.VariableInductor variableInductor
            annotation (Placement(transformation(
                extent={{-10,10},{10,-10}},
                rotation=-90,
                origin={-20,70})));
          Modelica.Blocks.Sources.Ramp ramp_L(
            duration=1,
            startTime=3,
            offset=0.1,
            height=-0.09) annotation (Placement(transformation(
                extent={{-10,-10},{10,10}},
                rotation=90,
                origin={-40,30})));
          Modelica.Electrical.Analog.Sources.SignalVoltage signalVoltage annotation (
              Placement(transformation(
                extent={{-10,-10},{10,10}},
                rotation=-90,
                origin={40,70})));
          Modelica.Blocks.Sources.RealExpression V_sens(y=sens.V*sin(sens.term.theta[
                1])) annotation (Placement(transformation(
                extent={{30,-10},{-30,10}},
                rotation=-90,
                origin={70,48})));
        equation
          connect(const.y,pv. G)
            annotation (Line(points={{81,-10},{90,-10},{90,-28}},
                                                               color={0,0,127}));
          connect(sens2.terminal_n,fixVol. terminal)
            annotation (Line(points={{-10,-40},{-20,-40}},
                                                      color={0,120,120}));
          connect(sens.term,sens2. terminal_p)
            annotation (Line(points={{20,-29},{20,-40},{10,-40}},
                                                               color={0,120,120}));
          connect(pv.terminal,sens2. terminal_p)
            annotation (Line(points={{80,-40},{10,-40}},
                                                       color={0,120,120}));
          connect(variableInductor.L, ramp_L.y) annotation (Line(points={{-30.8,70},
                  {-40,70},{-40,41}}, color={0,0,127}));
          connect(ramp_R.y, variableResistor.R) annotation (Line(points={{-80,41},{
                  -80,70},{-71,70}}, color={0,0,127}));
          connect(variableInductor.n, interface_MBL1.p_i)
            annotation (Line(points={{-20,60},{0,60}}, color={0,0,255}));
          connect(variableResistor.n, interface_MBL1.p_i)
            annotation (Line(points={{-60,60},{0,60}}, color={0,0,255}));
          connect(V_sens.y, signalVoltage.v) annotation (Line(points={{70,81},{58,
                  81},{58,70},{47,70}}, color={0,0,127}));
          connect(ground1.p, signalVoltage.n)
            annotation (Line(points={{40,60},{40,60}}, color={0,0,255}));
          connect(signalVoltage.p, interface_MBL1.p_v)
            annotation (Line(points={{40,80},{10,80},{10,70}}, color={0,0,255}));
          connect(variableInductor.p, signalVoltage.p)
            annotation (Line(points={{-20,80},{40,80}}, color={0,0,255}));
          connect(variableResistor.p, signalVoltage.p)
            annotation (Line(points={{-60,80},{40,80}}, color={0,0,255}));
          connect(interface_MBL1.n_i, signalVoltage.n)
            annotation (Line(points={{20,60},{40,60}}, color={0,0,255}));
          connect(interface_MBL1.term_n, sens2.terminal_p) annotation (Line(points=
                  {{10,49},{10,0},{40,0},{40,-40},{10,-40}}, color={0,120,120}));
          annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
                coordinateSystem(preserveAspectRatio=false)));
        end Test_MBL;
      end Examples;
    end Interfacing;
  end Dynamic;

  package Optimization
    package Model
      model Test1
        parameter Real capctrl=1;
        Modelica.Blocks.Math.Gain gain(k=capctrl)
          annotation (Placement(transformation(extent={{-20,40},{0,60}})));
        Modelica.Blocks.Interfaces.RealInput u
          annotation (Placement(transformation(extent={{-140,-20},{-100,20}})));
        Modelica.Blocks.Interfaces.RealOutput y
          annotation (Placement(transformation(extent={{100,-10},{120,10}})));
        Modelica.Blocks.Math.Add add
          annotation (Placement(transformation(extent={{20,-10},{40,10}})));
        Modelica.Blocks.Sources.Sine sine(amplitude=1, freqHz=2)
          annotation (Placement(transformation(extent={{-60,40},{-40,60}})));
      equation
        connect(add.y, y)
          annotation (Line(points={{41,0},{110,0},{110,0}}, color={0,0,127}));
        connect(add.u1, gain.y)
          annotation (Line(points={{18,6},{10,6},{10,50},{1,50}}, color={0,0,127}));
        connect(add.u2, u) annotation (Line(points={{18,-6},{-44,-6},{-44,0},{-120,0}},
              color={0,0,127}));
        connect(sine.y, gain.u) annotation (Line(points={{-39,50},{-30,50},{-22,
                50}}, color={0,0,127}));
        annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
              coordinateSystem(preserveAspectRatio=false)));
      end Test1;
    end Model;

    package Examples
        extends Modelica.Icons.ExamplesPackage;

    end Examples;
  end Optimization;

  package Reporting

    model Capacitor
      parameter Real C( unit="F");
      input Real V( unit="V");
      output Real I( unit="A");
    equation
      I = C * der(V);
    end Capacitor;

    model Print_model
    equation
       DymolaCommands.Documentation.exportDiagram(
       "C:/Users/Christoph/Documents/SmartInverter/smartinverter_simulation/Models/SmartInverter/export.png",
       width=2000,
       height=2000,
       trim=true,
       modelToExport="SmartInverter.Systems.FLEXGRID");
      annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
            coordinateSystem(preserveAspectRatio=false)));
    end Print_model;
  end Reporting;

  package Development

    model Inverter_old
      import Flexgrid = SCooDER;
      parameter Modelica.SIunits.Voltage V_nominal(min=0, start=240)
        "Nominal voltage (V_nominal >= 0)";
      parameter Real etaPV(min=0, max=1, unit="1") = 0.95
        "Inverter conversion efficiency";
      parameter Real etaBatt(min=0, max=1, unit="1") = 0.95
        "Inverter conversion efficiency";

      Buildings.Electrical.AC.OnePhase.Interfaces.Terminal_n term_p
        annotation (Placement(transformation(extent={{-110,-10},{-90,10}})));
      Modelica.Blocks.Math.Add P_sum "Sum of Power generation/demand"
        annotation (Placement(transformation(extent={{50,-10},{30,10}})));
      Modelica.Blocks.Interfaces.RealInput Power_PV(unit="W")
        "Power generation from PV (pos if produced)" annotation (Placement(
            transformation(
            extent={{-20,-20},{20,20}},
            rotation=180,
            origin={120,40}), iconTransformation(
            extent={{-20,-20},{20,20}},
            rotation=180,
            origin={120,40})));
      Modelica.Blocks.Interfaces.RealInput Power_Battery(unit="W")
        "Power to/from Battery (pos if produced)" annotation (Placement(
            transformation(
            extent={{-20,-20},{20,20}},
            rotation=180,
            origin={120,-40}), iconTransformation(
            extent={{-20,-20},{20,20}},
            rotation=180,
            origin={120,-40})));
      Modelica.Blocks.Interfaces.RealInput pf(start = 1) "Powerfactor of Inverter" annotation (
         Placement(transformation(
            extent={{-20,-20},{20,20}},
            rotation=90,
            origin={0,-120}), iconTransformation(
            extent={{-20,-20},{20,20}},
            rotation=90,
            origin={0,-122})));
      Buildings.Electrical.AC.OnePhase.Sensors.GeneralizedSensor sens_Inverter
        annotation (Placement(transformation(extent={{-80,-10},{-60,10}})));
      Modelica.Blocks.Math.Gain efficiency_PV(k=-1*etaPV)
        "Inverter DC-AC conversion efficiency and Invert signal"
        annotation (Placement(transformation(extent={{90,30},{70,50}})));
      Modelica.Blocks.Math.Gain invert1(k=-1*etaBatt)
        annotation (Placement(transformation(extent={{90,-50},{70,-30}})));
      //Modelica.Blocks.Sources.RealExpression ActivePower(y=if (P_sum.y>1 or P_sum.y<-1) then ((sens_Inverter.V^2/P_sum.y) - 1)/(10000 - 1) else 10000)
      //Modelica.Blocks.Sources.RealExpression ActivePower(y=if (P_sum.y>1 or P_sum.y<-1) then ((sens_Inverter.V^2/abs(P_sum.y)) - 1)/(10000 - 1) else 1)
      //Modelica.Blocks.Sources.RealExpression ActivePower(y=if ((sens_Inverter.V^2/abs(P_sum.y)) - 1)/(1e5 - 1)<1 then ((sens_Inverter.V^2/abs(P_sum.y)) - 1)/(1e5 - 1) else 1)
      //Modelica.Blocks.Sources.RealExpression ActivePower(y=P_sum.y)
      Modelica.Blocks.Sources.RealExpression ActivePower(y=homotopy(actual = if (P_sum.y>2 or P_sum.y<-2) then P_sum.y else 2, simplified=0))
        annotation (Placement(transformation(extent={{36,18},{16,38}})));
      //Modelica.Blocks.Sources.RealExpression ActivePower(y=homotopy(actual = smooth(0,noEvent(if (P_sum.y>1 or P_sum.y<-1) then ((sens_Inverter.V^2/P_sum.y) - 1)/(10000 - 1) else 10000)), simplified=10000))
      Modelica.Blocks.Sources.RealExpression PF(y=1)
        annotation (Placement(transformation(extent={{18,58},{-2,78}})));
      Modelica.Blocks.Sources.RealExpression ReactivePower_L(y=500)
        annotation (Placement(transformation(extent={{20,-30},{0,-10}})));
      Modelica.Blocks.Continuous.FirstOrder filter_Z_R(
        k=1,
        y_start=1,
        T=1,
        initType=Modelica.Blocks.Types.Init.SteadyState)
                annotation (Placement(transformation(
            extent={{-6,6},{6,-6}},
            rotation=180,
            origin={0,52})));
      Flexgrid.Development.CapacitiveLoad loa1(V_nominal=240)
        annotation (Placement(transformation(extent={{-40,30},{-20,50}})));
      Modelica.Blocks.Continuous.FirstOrder filter_Z_R1(
        k=1,
        y_start=1,
        T=1,
        initType=Modelica.Blocks.Types.Init.SteadyState)
                annotation (Placement(transformation(
            extent={{-6,6},{6,-6}},
            rotation=90,
            origin={-10,0})));
    equation
      //Z_R.y_R = smooth(1, noEvent(if (P_sum.y>1 or P_sum.y<-1) then ((sens_Inverter.V^2/P_sum.y) - 1)/(10000 - 1) else 10000));
      //filter_Z_R.u = if (P_sum.y>1 or P_sum.y<-1) then ((sens_Inverter.V^2/P_sum.y) - 1)/(10000 - 1) else 10000;

      connect(sens_Inverter.terminal_n, term_p)
        annotation (Line(points={{-80,0},{-100,0}}, color={0,120,120}));
      connect(Power_PV, efficiency_PV.u)
        annotation (Line(points={{120,40},{92,40}}, color={0,0,127}));
      connect(invert1.u, Power_Battery)
        annotation (Line(points={{92,-40},{120,-40}}, color={0,0,127}));
      connect(efficiency_PV.y, P_sum.u1)
        annotation (Line(points={{69,40},{62,40},{62,6},{52,6}}, color={0,0,127}));
      connect(invert1.y, P_sum.u2) annotation (Line(points={{69,-40},{69,-23},{52,-23},
              {52,-6}}, color={0,0,127}));
      connect(loa1.terminal, sens_Inverter.terminal_p) annotation (Line(points={{-40,
              40},{-50,40},{-50,0},{-60,0}}, color={0,120,120}));
      connect(loa1.pf_in, filter_Z_R1.y)
        annotation (Line(points={{-20,46},{-10,46},{-10,6.6}}, color={0,0,127}));
      connect(filter_Z_R1.u, pf) annotation (Line(points={{-10,-7.2},{-10,-120},{0,-120}},
            color={0,0,127}));
      connect(ActivePower.y, filter_Z_R.u)
        annotation (Line(points={{15,28},{12,28},{12,52},{7.2,52}},
                                                             color={0,0,127}));
      connect(loa1.Pow, ActivePower.y) annotation (Line(points={{-20,40},{-4,40},{
              -4,28},{15,28}}, color={0,0,127}));
      annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
            coordinateSystem(preserveAspectRatio=false)));
    end Inverter_old;

    model CapacitiveLoad "Model of a capacitive and resistive load"
      extends .SCooDER.Development.CapacitiveLoad_partial(
        redeclare package PhaseSystem =
            Buildings.Electrical.PhaseSystems.OnePhase,
        redeclare Buildings.Electrical.AC.OnePhase.Interfaces.Terminal_n
          terminal,
        V_nominal(start=120));

      //extends Buildings.Electrical.Interfaces.CapacitiveLoad(

    protected
      Modelica.SIunits.Angle theRef "Absolute angle of rotating reference system";

    initial equation

    equation
      theRef = PhaseSystem.thetaRef(terminal.theta);
      omega = der(theRef);

      i[1] = -homotopy(actual = (v[2]*Q + v[1]*P)/(v[1]^2 + v[2]^2), simplified=0.0);
      i[2] = -homotopy(actual = (v[2]*P - v[1]*Q)/(v[1]^2 + v[2]^2), simplified=0.0);
      Y = {0, 0};
      q = {0, 0};

      annotation (
        defaultComponentName="loa",
        Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,
                -100},{100,100}}),      graphics={
            Rectangle(
              extent={{-80,40},{80,-40}},
              lineColor={0,0,0},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid),
            Line(
              points={{0,28},{0,-28}},
              color={0,0,0},
              origin={48,0},
              rotation=180),
            Line(
              points={{0,28},{0,-28}},
              color={0,0,0},
              origin={40,0},
              rotation=180),
              Line(points={{-42,-5.14335e-15},{10,0}},
                                             color={0,0,0},
              origin={-2,0},
              rotation=180),
              Line(points={{-26,-3.18398e-15},{0,0}},
                                             color={0,0,0},
              origin={48,0},
              rotation=180),
              Line(points={{-10,-1.22461e-15},{10,0}},
                                             color={0,0,0},
              origin={-82,0},
              rotation=180),
            Rectangle(
              extent={{-11,30},{11,-30}},
              lineColor={0,0,0},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid,
              origin={-42,1},
              rotation=90),
            Text(
              extent={{-120,80},{120,40}},
              lineColor={0,0,0},
              textString="%name")}), Documentation(info="<html>

<p>
Model of an capacitive load. It may be used to model a bank of capacitors.
</p>
<p>
The model computes the complex power vector as
<p align=\"center\" style=\"font-style:italic;\">
S = P + jQ = V &sdot; i<sup>*</sup>
</p>
<p>
where <i>V</i> is the voltage phasor and <i>i<sup>*</sup></i> is the complex
conjugate of the current phasor. The voltage and current phasors are shifted
by an angle <i>&phi;</i>.
</p>

<p>
The load model takes as input the power consumed by the inductive load and
the power factor <i>pf=cos(&phi;)</i>. The power
can be either fixed using the parameter <code>P_nominal</code>, or
it is possible to specify a variable power using the inputs <code>y</code> or
<code>Pow</code>.

The power factor can be either specified by the parameter <code>pf</code>
or using the input variable <code>pf_in</code>.

The different modes can be selected with the parameter
<code>mode</code> and <code>use_pf_in</code>, see <a href=\"modelica://Buildings.Electrical.Interfaces.Load\">
Buildings.Electrical.Interfaces.Load</a> and
<a href=\"modelica://Buildings.Electrical.Interfaces.CapacitiveLoad\">
Buildings.Electrical.Interfaces.CapacitiveLoad</a> for more information.
</p>

<p>
Given the active power <i>P</i> and the power factor <i>pf</i> the complex
power <i>Q</i> is computed as
</p>

<p align=\"center\" style=\"font-style:italic;\">
Q = - P  tan(arccos(pf)).
</p>

<p>
The equations of the model can be rewritten as
</p>
<p align=\"center\" style=\"font-style:italic;\">
i<sub>1</sub> = (P V<sub>1</sub> + Q V<sub>2</sub>)/(V<sub>1</sub><sup>2</sup> + V<sub>2</sub><sup>2</sup>),
</p>
<p align=\"center\" style=\"font-style:italic;\">
i<sub>2</sub> = (P V<sub>2</sub> - Q V<sub>1</sub>)/(V<sub>1</sub><sup>2</sup> + V<sub>2</sub><sup>2</sup>),
</p>

<p>
where <i>i<sub>1</sub></i>, <i>i<sub>2</sub></i>, <i>V<sub>1</sub></i>, and <i>V<sub>2</sub></i>
are the real and imaginary parts of the current and voltage phasors.
</p>
<p>
The nonlinearity of the model is due to the fact that the load consumes the power specified by the variables <i>P</i>
and <i>Q</i> irrespectively of the voltage of the load.
</p>
<p>
When multiple loads are connected in a grid through cables that cause voltage drops,
the dimension of the system of nonlinear equations increases linearly with the number of loads.
This nonlinear system of equations introduces challenges during the initialization,
as Newton solvers may diverge if initialized far from a solution, as well during the simulation.
In this situation, the model can be parameterized to use a linear approximation
as discussed in the next section.
</p>

<h4>Linearized model</h4>
<p>
Given the constraints and the two-dimensional nature of the problem, it is difficult to
find a linearized version of the AC load model. A solution could be to divide the voltage
domain into sectors, and for each sector compute the best linear approximation.
However the selection of the proper approximation depending on the value of the
voltage can generate events that increase the simulation time. For these reasons, the
linearized model assumes a voltage that is equal to the nominal value
</p>
<p align=\"center\" style=\"font-style:italic;\">
i<sub>1</sub> = (P V<sub>1</sub> + Q V<sub>2</sub>)/V<sub>RMS</sub><sup>2</sup>,
</p>
<p align=\"center\" style=\"font-style:italic;\">
i<sub>2</sub> = (P V<sub>2</sub> - Q V<sub>1</sub>)/V<sub>RMS</sub><sup>2</sup>,
</p>
<p>
where <i>V<sub>RMS</sub></i> is the Root Mean Square voltage os the AC system.
Even though this linearized version of the load model introduces an approximation
error in the current, it satisfies the contraints related to the ratio of the
active and reactive powers.
</p>

<h4>Initialization</h4>
<p>
The initialization problem can be simplified using the homotopy operator. The homotopy operator
uses two different types of equations to compute the value of a variable: the actual one
and a simplified one. The actual equation is the one used during the normal operation.
During initialization, the simplified equation is first solved and then slowly replaced
with the actual equation to compute the initial values for the nonlinear systems of
equations. The load model uses the homotopy operator, with the linearized model being used
as the simplified equation. This numerical expedient has proven useful when simulating models
with more than ten connected loads.
</p>
<p>
The load model has a parameter <code>initMode</code> that can be used to select
the assumption to use during the initialization phase by the homotopy operator.
The choices are between a null current or the linearized model.
</p>


</html>", revisions="<html>
<ul>
<li>
May 26, 2016, by Michael Wetter:<br/>
Moved function call to <code>PhaseSystem.thetaRef</code> out of
derivative operator as this is not yet supported by JModelica.
</li>
<li>September 4, 2014, by Michael Wetter:<br/>
Revised documentation.
</li>
<li>August 5, 2014, by Marco Bonvini:<br/>
Revised documentation.
</li>
<li>
January 2, 2012, by Michael Wetter:<br/>
First implementation.
</li>
</ul>
</html>"));
    end CapacitiveLoad;

    model Inverter_Resistive
      import Flexgrid = SCooDER;
      parameter Modelica.SIunits.Voltage V_nominal(min=0, start=240)
        "Nominal voltage (V_nominal >= 0)";
      parameter Real etaPV(min=0, max=1, unit="1") = 0.95
        "Inverter conversion efficiency";
      parameter Real etaBatt(min=0, max=1, unit="1") = 0.95
        "Inverter conversion efficiency";

      Buildings.Electrical.AC.OnePhase.Interfaces.Terminal_n term_p
        annotation (Placement(transformation(extent={{-110,-10},{-90,10}})));
      Modelica.Blocks.Math.Add P_sum "Sum of Power generation/demand"
        annotation (Placement(transformation(extent={{50,-10},{30,10}})));
      Modelica.Blocks.Interfaces.RealInput Power_PV(unit="W")
        "Power generation from PV (pos if produced)" annotation (Placement(
            transformation(
            extent={{-20,-20},{20,20}},
            rotation=180,
            origin={120,40}), iconTransformation(
            extent={{-20,-20},{20,20}},
            rotation=180,
            origin={120,40})));
      Modelica.Blocks.Interfaces.RealInput Power_Battery(unit="W")
        "Power to/from Battery (pos if produced)" annotation (Placement(
            transformation(
            extent={{-20,-20},{20,20}},
            rotation=180,
            origin={120,-40}), iconTransformation(
            extent={{-20,-20},{20,20}},
            rotation=180,
            origin={120,-40})));
      Modelica.Blocks.Interfaces.RealInput pf(start = 1) "Powerfactor of Inverter" annotation (
         Placement(transformation(
            extent={{-20,-20},{20,20}},
            rotation=90,
            origin={0,-120}), iconTransformation(
            extent={{-20,-20},{20,20}},
            rotation=90,
            origin={0,-122})));
      Buildings.Electrical.AC.OnePhase.Sensors.GeneralizedSensor sens_Inverter
        annotation (Placement(transformation(extent={{-80,-10},{-60,10}})));
      Modelica.Blocks.Math.Gain efficiency_PV(k=-1*etaPV)
        "Inverter DC-AC conversion efficiency and Invert signal"
        annotation (Placement(transformation(extent={{90,30},{70,50}})));
      Modelica.Blocks.Math.Gain invert1(k=-1*etaBatt)
        annotation (Placement(transformation(extent={{90,-50},{70,-30}})));
      Buildings.Electrical.AC.OnePhase.Loads.Impedance Z_R(
        R=100,
        RMin=1,
        RMax=1e5,
        use_R_in=true)
             "Impedance with variable R"
        annotation (Placement(transformation(extent={{-10,-10},{10,10}},
            rotation=0,
            origin={-30,40})));
      //Modelica.Blocks.Sources.RealExpression ActivePower(y=if (P_sum.y>1 or P_sum.y<-1) then ((sens_Inverter.V^2/P_sum.y) - 1)/(10000 - 1) else 10000)
      //Modelica.Blocks.Sources.RealExpression ActivePower(y=if (P_sum.y>1 or P_sum.y<-1) then ((sens_Inverter.V^2/abs(P_sum.y)) - 1)/(10000 - 1) else 1)
      Modelica.Blocks.Sources.RealExpression ActivePower(y=if ((sens_Inverter.V^2/abs(P_sum.y)) - 1)/(1e5 - 1)<1 then ((sens_Inverter.V^2/abs(P_sum.y)) - 1)/(1e5 - 1) else 1)
        annotation (Placement(transformation(extent={{20,50},{0,70}})));
      //Modelica.Blocks.Sources.RealExpression ActivePower(y=homotopy(actual = smooth(0,noEvent(if (P_sum.y>1 or P_sum.y<-1) then ((sens_Inverter.V^2/P_sum.y) - 1)/(10000 - 1) else 10000)), simplified=10000))
      Modelica.Blocks.Sources.RealExpression ReactivePower_C(y=1)
        annotation (Placement(transformation(extent={{20,10},{0,30}})));
      Modelica.Blocks.Sources.RealExpression ReactivePower_L(y=0)
        annotation (Placement(transformation(extent={{20,-30},{0,-10}})));
      Modelica.Blocks.Continuous.FirstOrder filter_Z_R(
        k=1,
        initType=Modelica.Blocks.Types.Init.SteadyState,
        y_start=1,
        T=1)    annotation (Placement(transformation(
            extent={{-6,6},{6,-6}},
            rotation=180,
            origin={-14,60})));
      Flexgrid.Development.invert_load invert_load1
        annotation (Placement(transformation(extent={{-58,50},{-78,70}})));
    equation
      //Z_R.y_R = smooth(1, noEvent(if (P_sum.y>1 or P_sum.y<-1) then ((sens_Inverter.V^2/P_sum.y) - 1)/(10000 - 1) else 10000));
      //filter_Z_R.u = if (P_sum.y>1 or P_sum.y<-1) then ((sens_Inverter.V^2/P_sum.y) - 1)/(10000 - 1) else 10000;

      connect(sens_Inverter.terminal_n, term_p)
        annotation (Line(points={{-80,0},{-100,0}}, color={0,120,120}));
      connect(Power_PV, efficiency_PV.u)
        annotation (Line(points={{120,40},{92,40}}, color={0,0,127}));
      connect(invert1.u, Power_Battery)
        annotation (Line(points={{92,-40},{120,-40}}, color={0,0,127}));
      connect(filter_Z_R.y, Z_R.y_R)
        annotation (Line(points={{-20.6,60},{-34,60},{-34,50}}, color={0,0,127}));
      connect(efficiency_PV.y, P_sum.u1)
        annotation (Line(points={{69,40},{62,40},{62,6},{52,6}}, color={0,0,127}));
      connect(invert1.y, P_sum.u2) annotation (Line(points={{69,-40},{69,-23},{52,-23},
              {52,-6}}, color={0,0,127}));
      connect(ActivePower.y, filter_Z_R.u)
        annotation (Line(points={{-1,60},{-6.8,60}},           color={0,0,127}));
      connect(invert_load1.term_p, Z_R.terminal) annotation (Line(points={{-57,60},
              {-48,60},{-48,40},{-40,40}}, color={0,120,120}));
      connect(invert_load1.term_n, sens_Inverter.terminal_p) annotation (Line(
            points={{-79,60},{-70,60},{-70,0},{-60,0}}, color={0,120,120}));
      annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
            coordinateSystem(preserveAspectRatio=false)));
    end Inverter_Resistive;

    model Inverter_backup
      parameter Modelica.SIunits.Voltage V_nominal(min=0, start=240)
        "Nominal voltage (V_nominal >= 0)";
      parameter Real etaPV(min=0, max=1, unit="1") = 0.95
        "Inverter conversion efficiency";
      parameter Real etaBatt(min=0, max=1, unit="1") = 0.95
        "Inverter conversion efficiency";

      Buildings.Electrical.AC.OnePhase.Interfaces.Terminal_n term_p
        annotation (Placement(transformation(extent={{-110,-10},{-90,10}})));
      Modelica.Blocks.Math.Add P_sum "Sum of Power generation/demand"
        annotation (Placement(transformation(extent={{50,-10},{30,10}})));
      Modelica.Blocks.Interfaces.RealInput Power_PV(unit="W")
        "Power generation from PV (pos if produced)" annotation (Placement(
            transformation(
            extent={{-20,-20},{20,20}},
            rotation=180,
            origin={120,40}), iconTransformation(
            extent={{-20,-20},{20,20}},
            rotation=180,
            origin={120,40})));
      Modelica.Blocks.Interfaces.RealInput Power_Battery(unit="W")
        "Power to/from Battery (pos if produced)" annotation (Placement(
            transformation(
            extent={{-20,-20},{20,20}},
            rotation=180,
            origin={120,-40}), iconTransformation(
            extent={{-20,-20},{20,20}},
            rotation=180,
            origin={120,-40})));
      Modelica.Blocks.Interfaces.RealInput pf(start = 1) "Powerfactor of Inverter" annotation (
         Placement(transformation(
            extent={{-20,-20},{20,20}},
            rotation=90,
            origin={0,-120}), iconTransformation(
            extent={{-20,-20},{20,20}},
            rotation=90,
            origin={0,-122})));
      Buildings.Electrical.AC.OnePhase.Sensors.GeneralizedSensor sens_Inverter
        annotation (Placement(transformation(extent={{-80,-10},{-60,10}})));
      Modelica.Blocks.Math.Gain efficiency_PV(k=-1*etaPV)
        "Inverter DC-AC conversion efficiency and Invert signal"
        annotation (Placement(transformation(extent={{90,30},{70,50}})));
      Modelica.Blocks.Math.Gain invert1(k=-1*etaBatt)
        annotation (Placement(transformation(extent={{90,-50},{70,-30}})));
      Modelica.Blocks.Continuous.FirstOrder filter_Batt(
        k=1,
        T=0.1,
        y_start=0,
        initType=Modelica.Blocks.Types.Init.SteadyState)
                annotation (Placement(transformation(
            extent={{-6,-6},{6,6}},
            rotation=90,
            origin={60,-20})));
      Modelica.Blocks.Continuous.FirstOrder filter_PV(
        k=1,
        T=0.1,
        y_start=0,
        initType=Modelica.Blocks.Types.Init.SteadyState)
                annotation (Placement(transformation(
            extent={{6,-6},{-6,6}},
            rotation=90,
            origin={60,20})));
      Buildings.Electrical.AC.OnePhase.Loads.Impedance Z_R(
        R=100,
        RMin=1,
        RMax=10000,
        use_R_in=true)
             "Impedance with variable R"
        annotation (Placement(transformation(extent={{-10,-10},{10,10}},
            rotation=0,
            origin={-30,40})));
     //Modelica.Blocks.Sources.RealExpression ActivePower(y=(, start=0)
     //  annotation (Placement(transformation(extent={{0,40},{-20,60}})));
      Modelica.Blocks.Sources.RealExpression ReactivePower_C(y=1)
        annotation (Placement(transformation(extent={{0,0},{-20,20}})));
      Modelica.Blocks.Sources.RealExpression ReactivePower_L(y=0)
        annotation (Placement(transformation(extent={{0,-40},{-20,-20}})));
    equation
      Z_R.y_R = smooth(1, noEvent(if (P_sum.y>1 or P_sum.y<-1) then ((sens_Inverter.V^2/(P_sum.y + 1e-2)) - 1)/(10000 - 1) else 10000));

      connect(sens_Inverter.terminal_n, term_p)
        annotation (Line(points={{-80,0},{-100,0}}, color={0,120,120}));
      connect(Power_PV, efficiency_PV.u)
        annotation (Line(points={{120,40},{92,40}}, color={0,0,127}));
      connect(invert1.u, Power_Battery)
        annotation (Line(points={{92,-40},{120,-40}}, color={0,0,127}));
      connect(P_sum.u2, filter_Batt.y)
        annotation (Line(points={{52,-6},{60,-6},{60,-13.4}}, color={0,0,127}));
      connect(filter_Batt.u, invert1.y)
        annotation (Line(points={{60,-27.2},{60,-40},{69,-40}}, color={0,0,127}));
      connect(efficiency_PV.y, filter_PV.u)
        annotation (Line(points={{69,40},{60,40},{60,27.2}}, color={0,0,127}));
      connect(filter_PV.y, P_sum.u1)
        annotation (Line(points={{60,13.4},{60,6},{52,6}}, color={0,0,127}));
      connect(Z_R.terminal, sens_Inverter.terminal_p) annotation (Line(points={{-40,
              40},{-50,40},{-50,0},{-60,0}}, color={0,120,120}));
      //connect(ActivePower.y, Z_R.y_R)
      //  annotation (Line(points={{-21,50},{-28,50},{-34,50}}, color={0,0,127}));
      annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
            coordinateSystem(preserveAspectRatio=false)));
    end Inverter_backup;

    model Play
      Buildings.Electrical.AC.ThreePhasesUnbalanced.Sources.FixedVoltage X2A(f=60, V=
            208) annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=0,
            origin={-92,70})));
      Buildings.Electrical.AC.ThreePhasesUnbalanced.Sensors.GeneralizedSensor sens_Bus240V
        annotation (Placement(transformation(extent={{-10,60},{10,80}})));
      Buildings.Electrical.AC.ThreePhasesUnbalanced.Sensors.GeneralizedSensor sens_MPZ
        annotation (Placement(transformation(extent={{-70,60},{-50,80}})));
      Buildings.Electrical.AC.ThreePhasesUnbalanced.Lines.TwoPortMatrixRL line2(
        Z11=1*{0.6810,0.6980},
        Z12=1*{0.0600,0.0780},
        Z13=1*{0.0600,0.0500},
        Z22=1*{0.6810,0.6980},
        Z23=1*{0.0600,0.0360},
        Z33=1*{0.6810,0.6980},
        V_nominal=240)                         "Line at primary side"
        annotation (Placement(transformation(extent={{-10,-10},{10,10}},
            rotation=-90,
            origin={20,50})));
      Modelica.Blocks.Sources.Ramp ramp1(
        startTime=0,
        offset=0,
        duration=60,
        height=-3e3)
        annotation (Placement(transformation(extent={{80,-30},{60,-10}})));
      Buildings.Electrical.AC.ThreePhasesUnbalanced.Loads.Resistive Inverter(
        V_nominal=240,
        P_nominal=-3e3,
        mode=Buildings.Electrical.Types.Load.VariableZ_P_input,
        loadConn=Buildings.Electrical.Types.LoadConnection.wye_to_wyeg)
        annotation (Placement(transformation(extent={{20,-30},{40,-10}})));
      Buildings.Electrical.AC.ThreePhasesUnbalanced.Sensors.GeneralizedSensor sens_Inverter
        annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=-90,
            origin={20,20})));
      Buildings.Electrical.AC.ThreePhasesUnbalanced.Conversion.ACACTransformerStepUpYD
        tra(
        XoverR=8/1,
        Zperc=sqrt(0.01^2 + 0.06^2),
        VHigh=120,
        VLow=240,
        VABase=200e3)
        annotation (Placement(transformation(extent={{-40,60},{-20,80}})));
    equation
      connect(Inverter.Pow1, ramp1.y) annotation (Line(points={{42,-12},{42,-12},{
              42,-20},{59,-20}}, color={0,0,127}));
      connect(Inverter.Pow2, ramp1.y) annotation (Line(points={{42,-20},{50,-20},{
              50,-10},{56,-10},{56,-20},{59,-20}}, color={0,0,127}));
      connect(Inverter.Pow3, ramp1.y)
        annotation (Line(points={{42,-28},{59,-28},{59,-20}}, color={0,0,127}));
      connect(X2A.terminal, sens_MPZ.terminal_n)
        annotation (Line(points={{-82,70},{-76,70},{-70,70}}, color={0,120,120}));
      connect(line2.terminal_p, sens_Inverter.terminal_n)
        annotation (Line(points={{20,40},{20,36},{20,30}}, color={0,120,120}));
      connect(sens_Inverter.terminal_p, Inverter.terminal)
        annotation (Line(points={{20,10},{20,10},{20,-20}}, color={0,120,120}));
      connect(sens_MPZ.terminal_p, tra.terminal_n)
        annotation (Line(points={{-50,70},{-45,70},{-40,70}}, color={0,120,120}));
      connect(tra.terminal_p, sens_Bus240V.terminal_n)
        annotation (Line(points={{-20,70},{-15,70},{-10,70}}, color={0,120,120}));
      connect(sens_Bus240V.terminal_p, line2.terminal_n)
        annotation (Line(points={{10,70},{20,70},{20,60}}, color={0,120,120}));
      annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
            coordinateSystem(preserveAspectRatio=false)));
    end Play;

    model Test_Inverter_old

      Buildings.Electrical.AC.OnePhase.Sources.FixedVoltage source(f=60, V=240)
        annotation (Placement(transformation(extent={{-100,-10},{-80,10}})));
      Buildings.Electrical.AC.OnePhase.Sensors.GeneralizedSensor sens_Inverter
        annotation (Placement(transformation(extent={{-60,-10},{-40,10}})));
      Modelica.Blocks.Sources.Constant pf(k=0.9)
        annotation (Placement(transformation(extent={{-40,-50},{-20,-30}})));
      Modelica.Blocks.Sources.Sine PV_generation(amplitude=1e3, freqHz=1/60)
        annotation (Placement(transformation(extent={{60,20},{40,40}})));
      Modelica.Blocks.Sources.Constant Battery(k=0)
        annotation (Placement(transformation(extent={{60,-30},{40,-10}})));
      Buildings.Electrical.AC.OnePhase.Loads.Impedance Z_R(
        R=100,
        RMin=100,
        RMax=10000,
        use_R_in=true)
             "Impedance with variable R"
        annotation (Placement(transformation(extent={{-10,-10},{10,10}},
            rotation=0,
            origin={-26,46})));
      Modelica.Blocks.Sources.Constant test(k=-1)
        annotation (Placement(transformation(extent={{-60,60},{-40,80}})));
      Buildings.Electrical.AC.OnePhase.Sources.FixedVoltage source1(
                                                                   f=60, V=240)
        annotation (Placement(transformation(extent={{-30,-12},{-10,8}})));
    equation
      connect(sens_Inverter.terminal_n, source.terminal)
        annotation (Line(points={{-60,0},{-70,0},{-80,0}}, color={0,120,120}));
      //connect(inverter.Inverter_terminal, sens_Inverter.terminal_p)
      //  annotation (Line(points={{-10,0},{-40,0}}, color={0,120,120}));
      connect(inverter.pf, pf.y) annotation (Line(points={{0,-12.2},{0,-12.2},{0,
              -40},{-19,-40}}, color={0,0,127}));
      connect(PV_generation.y, inverter.P_PV) annotation (Line(points={{39,30},
              {30,30},{30,4},{12,4}}, color={0,0,127}));
      connect(Battery.y, inverter.P_Batt) annotation (Line(points={{39,-20},{30,-20},
              {30,-4},{12,-4}}, color={0,0,127}));
      connect(Z_R.terminal, sens_Inverter.terminal_p) annotation (Line(points={{-36,
              46},{-38,46},{-38,0},{-40,0}}, color={0,120,120}));
      connect(test.y, Z_R.y_R) annotation (Line(points={{-39,70},{-34,70},{-34,56},
              {-30,56}}, color={0,0,127}));
      connect(inverter.term_p, source1.terminal)
        annotation (Line(points={{-10,0},{-10,-2}}, color={0,120,120}));
      annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
            coordinateSystem(preserveAspectRatio=false)));
    end Test_Inverter_old;

    model Develop_Inverter1
      Development.CapacitiveLoad load2(V_nominal=120)
        annotation (Placement(transformation(extent={{0,-10},{20,10}})));
      Modelica.Blocks.Sources.Sine Powerfactor(
        amplitude=1,
        freqHz=1,
        phase=0,
        offset=0)
        annotation (Placement(transformation(extent={{100,20},{80,40}})));
      Modelica.Blocks.Sources.Constant Load(k=100)
        annotation (Placement(transformation(extent={{70,-10},{50,10}})));
      Modelica.Blocks.Nonlinear.Limiter limiter(uMax=1, uMin=0.1)
        annotation (Placement(transformation(extent={{70,20},{50,40}})));
      Buildings.Electrical.AC.ThreePhasesUnbalanced.Interfaces.Adapter3to3 ada_1
        annotation (Placement(transformation(extent={{-40,-10},{-60,10}})));
      Components.Sensor.Model.Probe3ph sens_all
        annotation (Placement(transformation(extent={{-80,-10},{-60,10}})));
      Buildings.Electrical.AC.OnePhase.Sensors.GeneralizedSensor sens1
        annotation (Placement(transformation(
            extent={{10,10},{-10,-10}},
            rotation=180,
            origin={-20,30})));
      Buildings.Electrical.AC.OnePhase.Sensors.GeneralizedSensor sens2
        annotation (Placement(transformation(
            extent={{10,10},{-10,-10}},
            rotation=180,
            origin={-20,0})));
      Buildings.Electrical.AC.OnePhase.Sensors.GeneralizedSensor sens3
        annotation (Placement(transformation(
            extent={{10,10},{-10,-10}},
            rotation=180,
            origin={-20,-30})));
      Development.CapacitiveLoad load1(V_nominal=120)
        annotation (Placement(transformation(extent={{0,20},{20,40}})));
      Development.CapacitiveLoad load3(V_nominal=120)
        annotation (Placement(transformation(extent={{0,-40},{20,-20}})));
      Buildings.Electrical.AC.ThreePhasesUnbalanced.Sources.FixedVoltage source(f=60, V=
            208)
        annotation (Placement(transformation(extent={{10,-10},{-10,10}},
            rotation=180,
            origin={-90,0})));
      Modelica.Blocks.Sources.Sine Powerfactor1(
        amplitude=1,
        phase=0,
        offset=0,
        freqHz=0.5)
        annotation (Placement(transformation(extent={{100,-40},{80,-20}})));
      Modelica.Blocks.Nonlinear.Limiter limiter1(uMax=1, uMin=0.1)
        annotation (Placement(transformation(extent={{70,-40},{50,-20}})));
    equation
      connect(Powerfactor.y, limiter.u)
        annotation (Line(points={{79,30},{72,30}}, color={0,0,127}));
      connect(ada_1.terminal, sens_all.terminal_p)
        annotation (Line(points={{-60,0},{-60,0}}, color={0,120,120}));
      connect(sens1.terminal_n, ada_1.terminals[1]) annotation (Line(points={
              {-30,30},{-34,30},{-34,0.53333},{-40.2,0.53333}}, color={0,120,
              120}));
      connect(sens2.terminal_n, ada_1.terminals[2])
        annotation (Line(points={{-30,0},{-40.2,0}}, color={0,120,120}));
      connect(sens3.terminal_n, ada_1.terminals[3]) annotation (Line(points={
              {-30,-30},{-34,-30},{-34,-0.53333},{-40.2,-0.53333}}, color={0,
              120,120}));
      connect(load2.terminal, sens2.terminal_p)
        annotation (Line(points={{0,0},{0,0},{-10,0}}, color={0,120,120}));
      connect(sens1.terminal_p, load1.terminal) annotation (Line(points={{-10,
              30},{-6,30},{0,30}}, color={0,120,120}));
      connect(sens3.terminal_p, load3.terminal) annotation (Line(points={{-10,
              -30},{-5,-30},{0,-30}}, color={0,120,120}));
      connect(limiter.y, load1.pf_in) annotation (Line(points={{49,30},{40,30},
              {40,36},{20,36}}, color={0,0,127}));
      connect(Load.y, load1.Pow) annotation (Line(points={{49,0},{34,0},{34,
              30},{20,30}}, color={0,0,127}));
      connect(Load.y, load2.Pow)
        annotation (Line(points={{49,0},{34,0},{20,0}}, color={0,0,127}));
      connect(Load.y, load3.Pow) annotation (Line(points={{49,0},{34,0},{34,
              -30},{20,-30}}, color={0,0,127}));
      connect(limiter.y, load2.pf_in) annotation (Line(points={{49,30},{40,30},
              {40,6},{20,6}}, color={0,0,127}));
      connect(sens_all.terminal_n, source.terminal) annotation (Line(points={
              {-80,0},{-80,-1.33227e-015}}, color={0,120,120}));
      connect(limiter1.y, load3.pf_in) annotation (Line(points={{49,-30},{36,
              -30},{36,-24},{20,-24}}, color={0,0,127}));
      connect(Powerfactor1.y, limiter1.u)
        annotation (Line(points={{79,-30},{72,-30}}, color={0,0,127}));
      annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
            coordinateSystem(preserveAspectRatio=false)));
    end Develop_Inverter1;

    partial model CapacitiveLoad_partial "Partial model of a capacitive load"
      extends .SCooDER.Components.Inverter.Interfaces.Load_partial;
      //extends Buildings.Electrical.Interfaces.Load;
      //parameter Boolean use_pf_in = false "If true, the power factor is defined by an input"
      //  annotation(Dialog(group="Modeling assumption"));
      //parameter Real pf(min=0, max=1) = 0.8 "Power factor"
     // annotation(Dialog(group="Nominal conditions"));
      Modelica.Blocks.Interfaces.RealInput pf_in(
        min=0,
        max=1,
        unit="1") "Power factor"
                       annotation (Placement(transformation(
            extent={{-20,-20},{20,20}},
            rotation=180,
            origin={100,60}),  iconTransformation(
            extent={{-20,-20},{20,20}},
            rotation=180,
            origin={100,60})));  //if (use_pf_in)
    protected
      function j = PhaseSystem.j "J operator that rotates of 90 degrees";
      Modelica.Blocks.Interfaces.RealInput pf_internal
        "Hidden value of the input load for the conditional connector";
      Modelica.SIunits.ElectricCharge q[2](each stateSelect=StateSelect.prefer)
        "Electric charge";
      Modelica.SIunits.Admittance[2] Y "Admittance";
      Modelica.SIunits.AngularVelocity omega "Angular velocity";
      Modelica.SIunits.Power Q = P*tan(-acos(pf_internal))
        "Reactive power (negative because capacitive load)";
    equation
      connect(pf_in, pf_internal);

      //if not use_pf_in then
      //  pf_internal = pf;
      //end if;

      annotation (Documentation(revisions="<html>
<ul>
<li>
June 06, 2014, by Marco Bonvini:<br/>
Added power factor input <code>pf_in</code> and updated documentation.
</li>
<li>
May 15, 2014, by Marco Bonvini:<br/>
Created documentation.
</li>
<li>
October 31, 2013, by Marco Bonvini:<br/>
Model included into the Buildings library.
</li>
</ul>
</html>",     info="<html>
<p>
This is a model of a generic capacitive load. This model is an extension of the base load model
<a href=\"Buildings.Electrical.Interfaces.PartialLoad\">Buildings.Electrical.Interfaces.PartialLoad</a>.
</p>
<p>
This model assumes a fixed power factor <code>pf</code> when the flag <code>use_pf_in = false</code>
otherwise it uses the power factor specified by the input <code>pf_in</code>.
</p>
<p>The power factor (either the input or the parameter) is used to compute the reactive power
<code>Q</code> given the active power <code>P</code>
</p>
<p align=\"center\" style=\"font-style:italic;\">
Q = - P * tan(arccos(pf))
</p>
</html>"));
    end CapacitiveLoad_partial;

    partial model InductiveLoad_parital "Partial model of an inductive load"
      extends .SCooDER.Components.Inverter.Interfaces.Load_partial;
      //extends Buildings.Electrical.Interfaces.Load;
      /*parameter Boolean use_pf_in = false "If true, the power factor is defined by an input"
    annotation(Dialog(group="Modeling assumption"));
  parameter Real pf(min=0, max=1) = 0.8 "Power factor"
  annotation(Dialog(group="Nominal conditions"));*/
      Modelica.Blocks.Interfaces.RealInput pf_in(
        min=0,
        max=1,
        unit="1") "Power factor"
                       annotation (Placement(transformation(
            extent={{-20,-20},{20,20}},
            rotation=180,
            origin={100,60}),  iconTransformation(
            extent={{-20,-20},{20,20}},
            rotation=180,
            origin={100,60}))); //if (use_pf_in)
    protected
      function j = PhaseSystem.j "J operator that rotates of 90 degrees";
      Modelica.Blocks.Interfaces.RealInput pf_internal
        "Hidden value of the input load for the conditional connector";
      Modelica.SIunits.MagneticFlux psi[2](each stateSelect=StateSelect.prefer)
        "Magnetic flux";
      Modelica.SIunits.Impedance Z[2] "Impedance of the load";
      Modelica.SIunits.AngularVelocity omega "Angular frequency";
      Modelica.SIunits.Power Q = P*tan(acos(pf_internal))
        "Reactive power (positive because inductive load)";
    equation
      connect(pf_in, pf_internal);

      //if not use_pf_in then
      //  pf_internal = pf;
      //end if;

      annotation (Documentation(revisions="<html>
<ul>
<li>
June 06, 2014, by Marco Bonvini:<br/>
Added power factor input <code>pf_in</code> and updated documentation.
</li>
<li>
May 15, 2014, by Marco Bonvini:<br/>
Created documentation.
</li>
<li>
October 31, 2013, by Marco Bonvini:<br/>
Model included into the Buildings library.
</li>
</ul>
</html>",     info="<html>
<p>
This is a model of a generic inductive load. This model is an extension of the base load model
<a href=\"Buildings.Electrical.Interfaces.PartialLoad\">
Buildings.Electrical.Interfaces.PartialLoad</a>.
</p>
<p>
This model assumes a fixed power factor <code>pf</code> when the flag <code>use_pf_in = false</code>
otherwise it uses the power factor specified by the input <code>pf_in</code>.
</p>
<p>The power factor (either the input or the parameter) is used to compute the reactive power
<code>Q</code> given the active power <code>P</code>
</p>
<p align=\"center\" style=\"font-style:italic;\">
Q = P  tan(arccos(pf))
</p>
</html>"));
    end InductiveLoad_parital;

    model invert_load

      Buildings.Electrical.AC.OnePhase.Interfaces.Terminal_n term_n
        annotation (Placement(transformation(extent={{100,-10},{120,10}})));
      Buildings.Electrical.AC.OnePhase.Interfaces.Terminal_p term_p
        annotation (Placement(transformation(extent={{-120,-10},{-100,10}})));
    equation
      connect(term_n, term_p);
      //term_p = term_n;
      /*term_n.v[1] = term_p.v[1];
  term_n.v[2] = term_p.v[2];
  term_n.i[1] = -term_p.i[1];
  term_n.i[2] = term_p.i[2];
  term_n.theta = term_p.theta;*/

    end invert_load;

    model implement_detailed
      Buildings.Electrical.AC.OnePhase.Sources.FixedVoltage fixVol(f=60, V=120)
        annotation (Placement(transformation(extent={{-16,0},{4,20}})));
      Buildings.Electrical.AC.OnePhase.Sources.PVSimple pv(A=1)
        annotation (Placement(transformation(extent={{80,0},{100,20}})));
      Modelica.Blocks.Sources.Constant const(k=1000)
        annotation (Placement(transformation(extent={{104,30},{124,50}})));
      Modelica.Electrical.Analog.Sources.SignalVoltage signalVoltage annotation (
          Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=-90,
            origin={46,70})));
      Modelica.Electrical.Analog.Basic.Ground ground1
        annotation (Placement(transformation(extent={{36,40},{56,60}})));
      Buildings.Electrical.AC.OnePhase.Sensors.Probe sens(V_nominal=120, perUnit=false)
        annotation (Placement(transformation(extent={{50,20},{30,40}})));
      Modelica.Blocks.Sources.RealExpression realExpression2(y=sens.V*sin(sens.term.theta[
            1]))
        annotation (Placement(transformation(extent={{124,60},{64,80}})));
      Buildings.Electrical.AC.OnePhase.Sources.Generator gen
        annotation (Placement(transformation(extent={{20,-40},{40,-20}})));
      Modelica.Blocks.Math.Mean mean(f=60, x0=0)
        annotation (Placement(transformation(extent={{64,-88},{84,-68}})));
      Buildings.Electrical.AC.OnePhase.Sensors.GeneralizedSensor sens2
        annotation (Placement(transformation(extent={{10,0},{30,20}})));
      Modelica.Blocks.Sources.RealExpression realExpression(y=0)
        annotation (Placement(transformation(extent={{24,-88},{44,-68}})));
      Modelica.Blocks.Math.Product product
        annotation (Placement(transformation(extent={{-64,-56},{-44,-36}})));
      Modelica.Blocks.Math.Product product1
        annotation (Placement(transformation(extent={{-64,-86},{-44,-66}})));
      Modelica.Blocks.Sources.RealExpression realExpression1(y=sin(sens.term.theta[1]))
        annotation (Placement(transformation(extent={{-102,-50},{-82,-30}})));
      Modelica.Blocks.Sources.RealExpression realExpression3(y=cos(sens.term.theta[1]))
        annotation (Placement(transformation(extent={{-106,-78},{-86,-58}})));
      Modelica.Blocks.Math.Mean mean1(f=60, x0=0)
        annotation (Placement(transformation(extent={{-28,-56},{-8,-36}})));
      Modelica.Blocks.Math.Mean mean2(f=60, x0=0)
        annotation (Placement(transformation(extent={{-28,-86},{-8,-66}})));
      Modelica.Blocks.Sources.RealExpression realExpression4(y=0)
        annotation (Placement(transformation(extent={{62,-24},{82,-4}})));

      Modelica.Electrical.Analog.Basic.VariableResistor variableResistor
        annotation (Placement(transformation(
            extent={{-10,10},{10,-10}},
            rotation=-90,
            origin={-60,80})));
      Modelica.Blocks.Sources.Ramp ramp(
        duration=1,
        startTime=1,
        offset=10,
        height=-8.5)
        annotation (Placement(transformation(extent={{-100,70},{-80,90}})));
      Dynamic.Sensor.Model.dynToPh dynToPh
        annotation (Placement(transformation(extent={{-30,50},{-10,70}})));
      Dynamic.Sensor.Model.dynToPQ dynToPQ
        annotation (Placement(transformation(extent={{0,50},{20,70}})));
      Modelica.Electrical.Analog.Basic.VariableInductor variableInductor
        annotation (Placement(transformation(
            extent={{-10,10},{10,-10}},
            rotation=-90,
            origin={-60,40})));
      Modelica.Blocks.Sources.Ramp ramp1(
        duration=1,
        startTime=1,
        offset=10,
        height=-8.5)
        annotation (Placement(transformation(extent={{-100,30},{-80,50}})));
    equation
      connect(const.y, pv.G)
        annotation (Line(points={{125,40},{90,40},{90,22}},color={0,0,127}));
      connect(gen.P, mean.y) annotation (Line(points={{20,-30},{102,-30},{102,-78},{
              85,-78}}, color={0,0,127}));
      connect(sens2.terminal_n, fixVol.terminal)
        annotation (Line(points={{10,10},{4,10}}, color={0,120,120}));
      connect(sens.term, sens2.terminal_p)
        annotation (Line(points={{40,21},{40,10},{30,10}}, color={0,120,120}));
      connect(gen.terminal, sens2.terminal_p)
        annotation (Line(points={{40,-30},{40,10},{30,10}}, color={0,120,120}));
      connect(pv.terminal, sens2.terminal_p)
        annotation (Line(points={{80,10},{30,10}}, color={0,120,120}));
      connect(realExpression.y, mean.u)
        annotation (Line(points={{45,-78},{62,-78}}, color={0,0,127}));
      connect(product1.u2, product.u2) annotation (Line(points={{-66,-82},{-92,-82},
              {-92,-52},{-66,-52}}, color={0,0,127}));
      connect(product.u1, realExpression1.y)
        annotation (Line(points={{-66,-40},{-81,-40}}, color={0,0,127}));
      connect(product1.u1, realExpression3.y) annotation (Line(points={{-66,-70},{
              -70,-70},{-70,-68},{-85,-68}},
                                         color={0,0,127}));
      connect(mean1.u, product.y) annotation (Line(points={{-30,-46},{-43,-46}},
                               color={0,0,127}));
      connect(mean2.u, product1.y)
        annotation (Line(points={{-30,-76},{-43,-76}}, color={0,0,127}));
      connect(realExpression2.y, signalVoltage.v) annotation (Line(points={{61,70},
              {53,70}},                   color={0,0,127}));
      connect(ramp.y, variableResistor.R)
        annotation (Line(points={{-79,80},{-71,80}}, color={0,0,127}));
      connect(dynToPh.p_v, signalVoltage.p)
        annotation (Line(points={{-20,70},{-20,80},{46,80}}, color={0,0,255}));
      connect(signalVoltage.n, ground1.p)
        annotation (Line(points={{46,60},{46,60}}, color={0,0,255}));
      connect(product.u2, realExpression1.y) annotation (Line(points={{-66,-52},{
              -72,-52},{-72,-40},{-81,-40}}, color={0,0,127}));
      connect(dynToPh.n_i, dynToPQ.p_i)
        annotation (Line(points={{-10,60},{0,60}}, color={0,0,255}));
      connect(dynToPQ.n_i, signalVoltage.n)
        annotation (Line(points={{20,60},{46,60}}, color={0,0,255}));
      connect(dynToPQ.p_v, signalVoltage.p)
        annotation (Line(points={{10,70},{10,80},{46,80}}, color={0,0,255}));
        annotation (Placement(transformation(extent={{-52,30},{-32,50}})),
                           Line(points={{-50,-10},{-54,-10},
              {-54,40},{-54,40}}, color={0,0,127}),
                  Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
            coordinateSystem(preserveAspectRatio=false)));
    end implement_detailed;

    partial model VoltageSource "Interface for voltage sources"
      extends Modelica.Electrical.Analog.Interfaces.OnePort;

      parameter Modelica.SIunits.Voltage offset=0 "Voltage offset";
      parameter Modelica.SIunits.Time startTime=0 "Time offset";
      replaceable Modelica.Blocks.Interfaces.SignalSource signalSource(
          final offset = offset, final startTime=startTime)
      annotation (Placement(transformation(extent={{70,70},{90,90}})));
    equation
      v = signalSource.y;
      annotation (
        Icon(coordinateSystem(
            preserveAspectRatio=true,
            extent={{-100,-100},{100,100}}), graphics={
            Ellipse(
              extent={{-50,50},{50,-50}},
              lineColor={0,0,255},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid),
            Text(
              extent={{-150,80},{150,120}},
              textString="%name",
              lineColor={0,0,255}),
            Line(points={{-90,0},{90,0}}, color={0,0,255}),
            Text(
              extent={{-120,50},{-20,0}},
              lineColor={0,0,255},
              textString="+"),
            Text(
              extent={{20,50},{120,0}},
              lineColor={0,0,255},
              textString="-")}),
        Documentation(revisions="<html>
<ul>
<li><i> 1998   </i>
       by Christoph Clauss<br> initially implemented<br>
       </li>
</ul>
</html>",   info="<html>
<p>The VoltageSource partial model prepares voltage sources by providing the pins, and the offset and startTime parameters, which are the same at all voltage sources. The source behavior is taken from Modelica.Blocks signal sources by inheritance and usage of the replaceable possibilities.</p>
</html>"));
    end VoltageSource;

    model Pv_Inv_VoltVarWatt_simple_Slim_PVzerohold
      // Weather data
      parameter String weather_file = "" "Path to weather file";
      // PV generation
      parameter Real n(min=0, unit="1") = 26 "Number of PV modules";
      parameter Real A(min=0, unit="m2") = 1.65 "Net surface area per module";
      parameter Real eta(min=0, max=1, unit="1") = 0.158
        "Module conversion efficiency";
      parameter Real lat(unit="deg") = 37.9 "Latitude";
      parameter Real til(unit="deg") = 10 "Surface tilt";
      parameter Real azi(unit="deg") = 0 "Surface azimuth 0-S, 90-W, 180-N, 270-E ";
      // VoltVarWatt
      parameter Real thrP = 0.05 "P: over/undervoltage threshold";
      parameter Real hysP= 0.04 "P: Hysteresis";
      parameter Real thrQ = 0.04 "Q: over/undervoltage threshold";
      parameter Real hysQ = 0.01 "Q: Hysteresis";
      parameter Real SMax(unit="VA") = 7600 "Maximal Apparent Power";
      parameter Real QMaxInd(unit="var") = 3300 "Maximal Reactive Power (Inductive)";
      parameter Real QMaxCap(unit="var") = 3300 "Maximal Reactive Power (Capacitive)";
      parameter Real Ts(unit="s") = 60 "Time constant of zero order hold";

      SCooDER.Components.Photovoltaics.Model.PVModule_simple_ZeroOrder
        pVModule_simple_ZeroOrder(
        n=n,
        A=A,
        eta=eta,
        lat=lat,
        til=til,
        azi=azi,
        Ts=Ts)
        annotation (Placement(transformation(extent={{-10,40},{10,60}})));
      Buildings.BoundaryConditions.WeatherData.ReaderTMY3 weaDatInpCon(
          computeWetBulbTemperature=false, filNam=weather_file)
        "Weather data reader with radiation data obtained from the inputs' connectors"
        annotation (Placement(transformation(extent={{-80,60},{-60,80}})));
      Modelica.Blocks.Interfaces.RealInput v(start=1, unit="1") "Voltage [p.u]"
        annotation (Placement(transformation(extent={{-140,-20},{-100,20}})));
      Modelica.Blocks.Interfaces.RealOutput Q(start=0, unit="var")
        "Reactive power in kVar"
        annotation (Placement(transformation(extent={{100,-60},{120,-40}})));
      Modelica.Blocks.Interfaces.RealOutput P(unit="W", start=0)
        "Active power in kW"
        annotation (Placement(transformation(extent={{100,40},{120,60}})));
      Modelica.Blocks.Math.Gain WtokW(k=1/1e3)
        annotation (Placement(transformation(extent={{20,40},{40,60}})));
      Modelica.Blocks.Math.Gain varTokvar(k=1/1e3)
        annotation (Placement(transformation(extent={{20,-60},{40,-40}})));
      Modelica.Blocks.Sources.RealExpression S_curtail_P(y=min(sqrt(SMax^2 - Q^2),
            WtokW.y)) annotation (Placement(transformation(extent={{0,-10},{80,10}})));
      SCooDER.Components.Controller.Model.voltVarWatt_param
        voltVarWatt_param(
        thrP=thrP,
        hysP=hysP,
        thrQ=thrQ,
        hysQ=hysQ,
        QMaxInd=QMaxInd*1000,
        QMaxCap=QMaxCap*1000)
        annotation (Placement(transformation(extent={{-50,-10},{-30,10}})));
    equation
      connect(weaDatInpCon.weaBus, pVModule_simple_ZeroOrder.weaBus)
        annotation (Line(
          points={{-60,70},{-40,70},{-40,54},{-10,54}},
          color={255,204,51},
          thickness=0.5));
      connect(pVModule_simple_ZeroOrder.P, WtokW.u)
        annotation (Line(points={{11,50},{18,50}}, color={0,0,127}));
      connect(pVModule_simple_ZeroOrder.scale, voltVarWatt_param.Plim)
        annotation (Line(points={{-12,46},{-20,46},{-20,5},{-29,5}}, color={0,
              0,127}));
      connect(voltVarWatt_param.Qctrl, varTokvar.u) annotation (Line(points={{-29,-5},
              {-20,-5},{-20,-50},{18,-50}}, color={0,0,127}));
      connect(varTokvar.y, Q)
        annotation (Line(points={{41,-50},{110,-50}}, color={0,0,127}));
      connect(P, S_curtail_P.y) annotation (Line(points={{110,50},{92,50},{92,
              0},{84,0}}, color={0,0,127}));
      connect(v, voltVarWatt_param.v)
        annotation (Line(points={{-120,0},{-52,0}}, color={0,0,127}));
      annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
            coordinateSystem(preserveAspectRatio=false)));
    end Pv_Inv_VoltVarWatt_simple_Slim_PVzerohold;

    model Pv_Inv_VoltVarWatt_simple_Slim_PVzerohold_Ctrlfirstorder
      // Weather data
      parameter String weather_file = "" "Path to weather file";
      // PV generation
      parameter Real n(min=0, unit="1") = 26 "Number of PV modules";
      parameter Real A(min=0, unit="m2") = 1.65 "Net surface area per module";
      parameter Real eta(min=0, max=1, unit="1") = 0.158
        "Module conversion efficiency";
      parameter Real lat(unit="deg") = 37.9 "Latitude";
      parameter Real til(unit="deg") = 10 "Surface tilt";
      parameter Real azi(unit="deg") = 0 "Surface azimuth 0-S, 90-W, 180-N, 270-E ";
      // VoltVarWatt
      parameter Real thrP = 0.05 "P: over/undervoltage threshold";
      parameter Real hysP= 0.04 "P: Hysteresis";
      parameter Real thrQ = 0.04 "Q: over/undervoltage threshold";
      parameter Real hysQ = 0.01 "Q: Hysteresis";
      parameter Real SMax(unit="VA") = 7600 "Maximal Apparent Power";
      parameter Real QMaxInd(unit="var") = 3300 "Maximal Reactive Power (Inductive)";
      parameter Real QMaxCap(unit="var") = 3300 "Maximal Reactive Power (Capacitive)";
      parameter Real Tfirstorder(unit="s") = 60 "Time constant of first order";
      parameter Real Ts(unit="s") = 5*60 "Time constant of zero order hold";

      SCooDER.Components.Photovoltaics.Model.PVModule_simple_ZeroOrder
        pVModule_simple_ZeroOrder(
        n=n,
        A=A,
        eta=eta,
        lat=lat,
        til=til,
        azi=azi,
        Ts=Ts)
        annotation (Placement(transformation(extent={{-10,40},{10,60}})));
      Buildings.BoundaryConditions.WeatherData.ReaderTMY3 weaDatInpCon(
          computeWetBulbTemperature=false, filNam=weather_file)
        "Weather data reader with radiation data obtained from the inputs' connectors"
        annotation (Placement(transformation(extent={{-80,60},{-60,80}})));
      Modelica.Blocks.Interfaces.RealInput v(start=1, unit="1")
        "Voltage [p.u]"
        annotation (Placement(transformation(extent={{-140,-20},{-100,20}})));
      Modelica.Blocks.Interfaces.RealOutput Q(start=0, unit="var")
        "Reactive power in kVar"
        annotation (Placement(transformation(extent={{100,-60},{120,-40}})));
      Modelica.Blocks.Interfaces.RealOutput P(unit="W", start=0)
        "Active power in kW"
        annotation (Placement(transformation(extent={{100,40},{120,60}})));
      Modelica.Blocks.Math.Gain WtokW(k=1/1e3)
        annotation (Placement(transformation(extent={{20,40},{40,60}})));
      Modelica.Blocks.Math.Gain varTokvar(k=1/1e3)
        annotation (Placement(transformation(extent={{20,-60},{40,-40}})));
      Modelica.Blocks.Sources.RealExpression S_curtail_P(y=min(sqrt(SMax^2 - Q^2),
            WtokW.y)) annotation (Placement(transformation(extent={{0,-10},{80,10}})));
      SCooDER.Components.Controller.Model.voltVarWatt_param_firstorder
        voltVarWatt_param_firstorder(
        thrP=thrP,
        hysP=hysP,
        thrQ=thrQ,
        hysQ=hysQ,
        QMaxInd=QMaxInd*1000,
        QMaxCap=QMaxCap*1000,
        Tfirstorder=Tfirstorder)
        annotation (Placement(transformation(extent={{-50,-10},{-30,10}})));
    equation
      connect(weaDatInpCon.weaBus, pVModule_simple_ZeroOrder.weaBus)
        annotation (Line(
          points={{-60,70},{-40,70},{-40,54},{-10,54}},
          color={255,204,51},
          thickness=0.5));
      connect(pVModule_simple_ZeroOrder.P, WtokW.u)
        annotation (Line(points={{11,50},{18,50}}, color={0,0,127}));
      connect(pVModule_simple_ZeroOrder.scale, voltVarWatt_param_firstorder.Plim)
        annotation (Line(points={{-12,46},{-20,46},{-20,5},{-29,5}}, color={0,0,127}));
      connect(voltVarWatt_param_firstorder.Qctrl, varTokvar.u) annotation (Line(
            points={{-29,-5},{-20,-5},{-20,-50},{18,-50}}, color={0,0,127}));
      connect(varTokvar.y, Q)
        annotation (Line(points={{41,-50},{110,-50}}, color={0,0,127}));
      connect(P, S_curtail_P.y) annotation (Line(points={{110,50},{92,50},{92,
              0},{84,0}}, color={0,0,127}));
      connect(v, voltVarWatt_param_firstorder.v)
        annotation (Line(points={{-120,0},{-52,0}}, color={0,0,127}));
      annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
            coordinateSystem(preserveAspectRatio=false)));
    end Pv_Inv_VoltVarWatt_simple_Slim_PVzerohold_Ctrlfirstorder;

    model Pv_Inv_VoltVarWatt_simple_Slim_zerohold
      // Weather data
      parameter String weather_file = "" "Path to weather file";
      // PV generation
      parameter Real n(min=0, unit="1") = 26 "Number of PV modules";
      parameter Real A(min=0, unit="m2") = 1.65 "Net surface area per module";
      parameter Real eta(min=0, max=1, unit="1") = 0.158
        "Module conversion efficiency";
      parameter Real lat(unit="deg") = 37.9 "Latitude";
      parameter Real til(unit="deg") = 10 "Surface tilt";
      parameter Real azi(unit="deg") = 0 "Surface azimuth 0-S, 90-W, 180-N, 270-E ";
      // VoltVarWatt
      parameter Real thrP = 0.05 "P: over/undervoltage threshold";
      parameter Real hysP= 0.04 "P: Hysteresis";
      parameter Real thrQ = 0.04 "Q: over/undervoltage threshold";
      parameter Real hysQ = 0.01 "Q: Hysteresis";
      parameter Real SMax(unit="VA") = 7600 "Maximal Apparent Power";
      parameter Real QMaxInd(unit="var") = 3300 "Maximal Reactive Power (Inductive)";
      parameter Real QMaxCap(unit="var") = 3300 "Maximal Reactive Power (Capacitive)";
      parameter Real Ts(unit="s") = 60 "Time constant of zero order hold";

      SCooDER.Components.Photovoltaics.Model.PVModule_simple
        pVModule_simple(
        n=n,
        A=A,
        eta=eta,
        lat=lat,
        til=til,
        azi=azi)
        annotation (Placement(transformation(extent={{-10,40},{10,60}})));
      Buildings.BoundaryConditions.WeatherData.ReaderTMY3 weaDatInpCon(
          computeWetBulbTemperature=false, filNam=weather_file)
        "Weather data reader with radiation data obtained from the inputs' connectors"
        annotation (Placement(transformation(extent={{-80,60},{-60,80}})));
      Modelica.Blocks.Interfaces.RealInput v(start=1, unit="1") "Voltage [p.u]"
        annotation (Placement(transformation(extent={{-140,-20},{-100,20}})));
      Modelica.Blocks.Interfaces.RealOutput Q(start=0, unit="var")
        "Reactive power in kVar"
        annotation (Placement(transformation(extent={{100,-60},{120,-40}})));
      Modelica.Blocks.Interfaces.RealOutput P(unit="W", start=0)
        "Active power in kW"
        annotation (Placement(transformation(extent={{100,40},{120,60}})));
      Modelica.Blocks.Math.Gain WtokW(k=1/1e3)
        annotation (Placement(transformation(extent={{20,40},{40,60}})));
      Modelica.Blocks.Math.Gain varTokvar(k=1/1e3)
        annotation (Placement(transformation(extent={{20,-60},{40,-40}})));
      Modelica.Blocks.Sources.RealExpression S_curtail_P(y=min(sqrt(SMax^2 - Q^2),
            WtokW.y)) annotation (Placement(transformation(extent={{0,-10},{80,10}})));
      SCooDER.Components.Controller.Model.voltVarWatt_param
        voltVarWatt_param(
        thrP=thrP,
        hysP=hysP,
        thrQ=thrQ,
        hysQ=hysQ,
        QMaxInd=QMaxInd*1000,
        QMaxCap=QMaxCap*1000)
        annotation (Placement(transformation(extent={{-50,-10},{-30,10}})));
      Modelica.Blocks.Discrete.ZeroOrderHold zeroOrderHold_v(samplePeriod=Ts)
        annotation (Placement(transformation(extent={{-90,-10},{-70,10}})));
      Modelica.Blocks.Discrete.ZeroOrderHold zeroOrderHold_q(samplePeriod=Ts)
        annotation (Placement(transformation(extent={{60,-60},{80,-40}})));
      Modelica.Blocks.Discrete.ZeroOrderHold zeroOrderHold_p(samplePeriod=Ts)
        annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=90,
            origin={90,30})));
    equation
      connect(weaDatInpCon.weaBus, pVModule_simple.weaBus) annotation (Line(
          points={{-60,70},{-40,70},{-40,54},{-10,54}},
          color={255,204,51},
          thickness=0.5));
      connect(pVModule_simple.P, WtokW.u)
        annotation (Line(points={{11,50},{18,50}}, color={0,0,127}));
      connect(pVModule_simple.scale, voltVarWatt_param.Plim) annotation (Line(
            points={{-12,46},{-20,46},{-20,5},{-29,5}}, color={0,0,127}));
      connect(voltVarWatt_param.Qctrl, varTokvar.u) annotation (Line(points={{-29,-5},
              {-20,-5},{-20,-50},{18,-50}}, color={0,0,127}));
      connect(v, zeroOrderHold_v.u)
        annotation (Line(points={{-120,0},{-92,0}}, color={0,0,127}));
      connect(zeroOrderHold_v.y, voltVarWatt_param.v)
        annotation (Line(points={{-69,0},{-52,0}}, color={0,0,127}));
      connect(varTokvar.y, zeroOrderHold_q.u)
        annotation (Line(points={{41,-50},{58,-50}}, color={0,0,127}));
      connect(zeroOrderHold_q.y, Q)
        annotation (Line(points={{81,-50},{110,-50}}, color={0,0,127}));
      connect(P, zeroOrderHold_p.y)
        annotation (Line(points={{110,50},{90,50},{90,41}}, color={0,0,127}));
      connect(zeroOrderHold_p.u, S_curtail_P.y)
        annotation (Line(points={{90,18},{90,0},{84,0}}, color={0,0,127}));
      annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
            coordinateSystem(preserveAspectRatio=false)));
    end Pv_Inv_VoltVarWatt_simple_Slim_zerohold;
  end Development;

annotation (
  uses(
 Modelica(version="3.2.2"),
    Complex(version="3.2.2"),
    CyDER(version="1"),
    Buildings(version="6.0.0"),
    SmartInverter(version="6"),
    DymolaCommands(version="1.5")),
  version="6",
  conversion(noneFromVersion="", noneFromVersion="1",
    noneFromVersion="2",
    noneFromVersion="3",
    noneFromVersion="4",
    noneFromVersion="5"));
end SCooDER;
