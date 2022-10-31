part of 'widgets.dart';

class DropdownButtonWidget extends StatefulWidget {
  List<SelectableThreadTopicModel> topics;
  String title;
  SelectableThreadTopicModel? selected;
  Function action;

  DropdownButtonWidget(
      {required this.topics,
      required this.title,
      required this.selected,
      required this.action});

  @override
  State<DropdownButtonWidget> createState() => _DropdownButtonWidgetState();
}

class _DropdownButtonWidgetState extends State<DropdownButtonWidget> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: DropdownButtonHideUnderline(
        child: DropdownButton2(
          hint: Text(
            widget.title,
            style: TextStyle(
              fontSize: 14,
              color: Theme.of(context).hintColor,
            ),
          ),
          items: widget.topics!
              .map((item) => DropdownMenuItem<SelectableThreadTopicModel>(
                    value: item,
                    child: Text(
                      item.name,
                      style: const TextStyle(
                        fontSize: 14,
                      ),
                    ),
                  ))
              .toList(),
          value: widget.selected,
          onChanged: (value) async {
            widget.action(value);
          },
          buttonHeight: 40,
          itemHeight: 40,
        ),
      ),
    );
  }
}
