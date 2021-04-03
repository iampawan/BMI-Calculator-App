import 'package:bmi_calculator/bmi_store.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:velocity_x/velocity_x.dart';
import '../components/icon_content.dart';
import '../components/page_bottom_button.dart';
import 'results_page.dart';
import '../components/reusable_card.dart';
import '../constants.dart';
import '../components/round_icon_button.dart';
import '../calculator.dart';

enum Sex { Male, Female }

class InputPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    BMIStore store = VxState.store as BMIStore;

    return Scaffold(
        appBar: AppBar(
          title: Text('BMI CALCULATOR'),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: VxBuilder(
                mutations: {ChangeGender},
                builder: (context, _) => Row(
                  children: [
                    Expanded(
                      child: ReusableCard(
                        color: store.maleCardColor,
                        child: IconContent(
                          label: "Male",
                          icon: FontAwesomeIcons.mars,
                        ),
                        onTap: () => ChangeGender(Sex.Male),
                      ),
                    ),
                    Expanded(
                      child: ReusableCard(
                        color: store.femaleCardColor,
                        child: IconContent(
                          label: "Female",
                          icon: FontAwesomeIcons.venus,
                        ),
                        onTap: () => ChangeGender(Sex.Female),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: Row(
                children: [
                  Expanded(
                    child: VxBuilder(
                      mutations: {ChangeHeight},
                      builder: (context, _) => ReusableCard(
                        color: kActiveCardColor,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "HEIGHT",
                              style: kLabelTextStyle,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.baseline,
                              textBaseline: TextBaseline.alphabetic,
                              children: [
                                Text(
                                  store.height.toString(),
                                  style: kLargeNumberLabelTextStyle,
                                ),
                                Text(
                                  "cm",
                                  style: kLabelTextStyle,
                                ),
                              ],
                            ),
                            SliderTheme(
                              data: SliderTheme.of(context).copyWith(
                                thumbShape: RoundSliderThumbShape(
                                  enabledThumbRadius: 15.0,
                                ),
                                overlayShape: RoundSliderOverlayShape(
                                  overlayRadius: 30.0,
                                ),
                                thumbColor: Colors.deepOrange,
                                overlayColor: Colors.deepOrange.shade900,
                                activeTrackColor: Colors.white,
                                inactiveTrackColor: Color(0xFF8D8E98),
                              ),
                              child: Slider(
                                value: store.height.toDouble(),
                                min: kSliderMin,
                                max: kSliderMax,
                                divisions: (kSliderMax - kSliderMin).toInt(),
                                onChanged: (double newValue) =>
                                    ChangeHeight(newValue.toInt()),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Row(
                children: [
                  Expanded(
                    child: VxBuilder(
                      mutations: {ChangeWeight},
                      builder: (context, _) => ReusableCard(
                        color: kActiveCardColor,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "WEIGHT",
                              style: kLabelTextStyle,
                            ),
                            Text(
                              store.weight.toString(),
                              style: kLargeNumberLabelTextStyle,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                RoundIconButton(
                                  icon: FontAwesomeIcons.plus,
                                  onPressed: () =>
                                      ChangeWeight(store.weight + 1),
                                ),
                                SizedBox(width: 10),
                                RoundIconButton(
                                  icon: FontAwesomeIcons.minus,
                                  onPressed: () =>
                                      ChangeWeight(store.weight - 1),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: VxBuilder(
                      mutations: {ChangeAge},
                      builder: (context, _) => ReusableCard(
                        color: kActiveCardColor,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "AGE",
                              style: kLabelTextStyle,
                            ),
                            Text(
                              store.age.toString(),
                              style: kLargeNumberLabelTextStyle,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                RoundIconButton(
                                  icon: FontAwesomeIcons.plus,
                                  onPressed: () => ChangeAge(store.age + 1),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                RoundIconButton(
                                  icon: FontAwesomeIcons.minus,
                                  onPressed: () => ChangeAge(store.age - 1),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
            PageBottomButton(
              label: 'CALCULATE',
              onPress: () {
                final calc =
                    Calculator(height: store.height, weight: store.weight);
                final bmi = calc.calculate();
                final result = calc.getResult();
                final interpretation = calc.getInterpretation();

                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ResultsPage(
                              bmi: bmi,
                              result: result,
                              interpretation: interpretation,
                            )));
              },
            ),
          ],
        ));
  }
}
