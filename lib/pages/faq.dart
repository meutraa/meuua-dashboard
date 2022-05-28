import 'package:flutter/material.dart';

class FAQPage extends StatefulWidget {
  const FAQPage({super.key});

  @override
  State<FAQPage> createState() => FAQPageState();
}

class FAQ {
  final String title;
  final String body;
  bool isExpanded = false;

  FAQ(this.title, this.body);
}

final faqs = <FAQ>[
  FAQ(
    'Meuua doesn\'t reply to people',
    '''The intelligent responses require an OpenAI access token to function.
            
You can get one by visiting https://openai.com/api/ and creating an account. Current costs are around \$0.06 per ~750 words (prompt + response).''',
  ),
  FAQ(
    'Can I stop meuua sending random messages?',
    '''Visit your channel in the channel list, and disable the "Auto Reply" feature. 

If you would prefer fewer messages, you can adjust the "Auto Reply Frequency" option instead.''',
  ),
];

class FAQPageState extends State<FAQPage> with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Padding(
      padding: const EdgeInsets.only(top: 24),
      child: SingleChildScrollView(
        child: ExpansionPanelList(
          expansionCallback: (panelIndex, isExpanded) {
            setState(() {
              faqs[panelIndex].isExpanded = !isExpanded;
            });
          },
          children: faqs.map((faq) {
            return ExpansionPanel(
              isExpanded: faq.isExpanded,
              canTapOnHeader: true,
              headerBuilder: (context, isExpanded) {
                return ListTile(
                  title: Text(faq.title),
                );
              },
              body: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Flexible(
                    child: Container(
                      padding: const EdgeInsets.only(
                        bottom: 16,
                        left: 16,
                        right: 16,
                      ),
                      child: Text(faq.body),
                    ),
                  ),
                ],
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
