class TimelineDay {
  final String dayNumber;
  final bool completed;
  final String changes;

  TimelineDay({
    required this.dayNumber,
    required this.completed,
    required this.changes,
  });
}


List<TimelineDay> getDummyTimelineDays() {
  return [
    TimelineDay(dayNumber: 'Day 1', completed: true, changes: '''Nicotine levels drops significantly.
begins experience of withdrawal symptoms such as cravings, irritability, and anxiety.
'''),
    TimelineDay(dayNumber: 'Day 2', completed: true, changes: '''Sense of smell and taste begin to improve.
Oxygen levels in the blood increase to normal.
'''),
    TimelineDay(dayNumber: 'Day 3', completed: true, changes: '''Nicotine withdrawal symptoms peaks.
Breathing becomes easier as bronchial tubes relax.'''),
    TimelineDay(dayNumber: 'Day 4', completed: true, changes: '''Carbon monoxide levels in the blood decrease.
Blood circulation improves.
'''),
    TimelineDay(dayNumber: 'Day 5', completed: true, changes: '''
Lung function begins to improve.
'''),
    TimelineDay(dayNumber: 'Day 10', completed: true, changes: '''Breathing becomes even easier as lung function improves.
Physical endurance may increase.
'''),
    TimelineDay(dayNumber: 'Day 20', completed: true, changes: '''Blood pressure and heart rate begin to normalize.
Lung function continues to improve.
'''),
    TimelineDay(dayNumber: 'Day 30', completed: true, changes: '''Overall energy levels increase.
Coughing and shortness of breath decrease.
'''),
    TimelineDay(dayNumber: '2 months', completed: false, changes: '''Circulation improves further.
Lung function continues to increase, reducing coughing and wheezing'''),
    TimelineDay(dayNumber: '3 months', completed: false, changes: '''Physical activities become easier.
Lung capacity increases, making breathing easier.'''),
    TimelineDay(dayNumber: '6 months', completed: false, changes: '''Cilia in the lungs start to repair, improving their ability to clear mucus.
Overall lung function improves.
'''),
    TimelineDay(dayNumber: '1 year', completed: false, changes: '''Risk of heart disease decreases by about 50%.
Coughing, sinus congestion, and fatigue decrease.'''),
    TimelineDay(dayNumber: '2 years', completed: false, changes: '''Risk of stroke decreases to that of a non-smoker.
Circulation continues to improve, reducing the risk of blood clots.
'''),
    TimelineDay(dayNumber: '3 years', completed: false, changes: '''Risk of heart disease decreases to that of a non-smoker.
Lung function continues to improve, reducing the risk of infections and respiratory issues.
'''),
    TimelineDay(dayNumber: '3 years', completed: false, changes: '''Risk of heart disease decreases to that of a non-smoker.
Lung function continues to improve, reducing the risk of infections and respiratory issues.
'''),
    TimelineDay(dayNumber: '4 years', completed: false, changes: '''Risk of mouth, throat, esophagus, and bladder cancer decreases significantly.
Overall risk of stroke decreases further.
'''),
  ];
}