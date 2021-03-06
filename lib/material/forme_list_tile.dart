import 'package:flutter/material.dart';
import 'package:forme_base_fields/forme_base_fields.dart';

import '../example.dart';
import '../forme_screen.dart';

class FormeListTileScreen extends FormeScreen {
  FormeListTileScreen({Key? key})
      : super(
            key: key,
            title: 'FormeListTile',
            builder: (context, key) {
              return [
                Example(
                  subTitle: 'split is 1, means ListTile like',
                  formeKey: key,
                  field: FormeListTile<String>(
                    split: 1,
                    name: 'checkbox-group',
                    type: FormeListTileType.checkbox,
                    items: [
                      FormeListTileItem(
                        secondary: const Icon(Icons.hourglass_empty),
                        title: const Text('item1'),
                        data: 'item1',
                      ),
                      FormeListTileItem(
                        secondary: const Icon(Icons.hourglass_empty),
                        title: const Text('item2'),
                        data: 'item2',
                      ),
                    ],
                  ),
                  title: 'FormeCheckboxGroup',
                ),
                Example(
                  subTitle: 'split is 3, means three checkboxes per line',
                  formeKey: key,
                  field: FormeListTile<String>(
                    split: 3,
                    name: 'checkbox-group2',
                    type: FormeListTileType.checkbox,
                    items: [
                      FormeListTileItem(
                        title: const Text('item1'),
                        data: 'item1',
                        controlAffinity: ListTileControlAffinity.leading,
                      ),
                      FormeListTileItem(
                        title: const Text('item2'),
                        data: 'item2',
                        controlAffinity: ListTileControlAffinity.leading,
                      ),
                      FormeListTileItem(
                        title: const Text('item3'),
                        data: 'item3',
                        controlAffinity: ListTileControlAffinity.leading,
                      ),
                      FormeListTileItem(
                        title: const Text('item4'),
                        data: 'item4',
                        controlAffinity: ListTileControlAffinity.leading,
                      ),
                      FormeListTileItem(
                        title: const Text('item5'),
                        data: 'item5',
                        controlAffinity: ListTileControlAffinity.leading,
                      ),
                    ],
                  ),
                  title: 'FormeCheckboxGroup2',
                ),
                Example(
                  subTitle:
                      'split is 0, means as much as possible checkboxes per line',
                  formeKey: key,
                  field: FormeListTile<String>(
                    split: 0,
                    name: 'checkbox-group3',
                    type: FormeListTileType.checkbox,
                    items: [
                      FormeListTileItem(
                        title: const Text('item1'),
                        data: 'item1',
                        controlAffinity: ListTileControlAffinity.leading,
                      ),
                      FormeListTileItem(
                        title: const Text('item2'),
                        data: 'item2',
                        controlAffinity: ListTileControlAffinity.leading,
                      ),
                      FormeListTileItem(
                        title: const Text('item3'),
                        data: 'item3',
                        controlAffinity: ListTileControlAffinity.leading,
                      ),
                      FormeListTileItem(
                        title: const Text('item4'),
                        data: 'item4',
                        controlAffinity: ListTileControlAffinity.leading,
                      ),
                      FormeListTileItem(
                        title: const Text('item5'),
                        data: 'item5',
                        controlAffinity: ListTileControlAffinity.leading,
                      ),
                    ],
                  ),
                  title: 'FormeCheckboxGroup3',
                ),
                Example(
                  subTitle: 'split is 1, means ListTile like',
                  formeKey: key,
                  field: FormeListTile<String>(
                    split: 1,
                    name: 'switch-group',
                    type: FormeListTileType.switchs,
                    items: [
                      FormeListTileItem(
                        secondary: const Icon(Icons.hourglass_empty),
                        title: const Text('item1'),
                        data: 'item1',
                      ),
                      FormeListTileItem(
                        secondary: const Icon(Icons.hourglass_empty),
                        title: const Text('item2'),
                        data: 'item2',
                      ),
                    ],
                  ),
                  title: 'FormeSwitchGroup',
                ),
                Example(
                  subTitle: 'split is 3, means three switchs per line',
                  formeKey: key,
                  field: FormeListTile<String>(
                    split: 3,
                    name: 'switch-group2',
                    type: FormeListTileType.switchs,
                    items: [
                      FormeListTileItem(
                        title: const Text('item1'),
                        data: 'item1',
                      ),
                      FormeListTileItem(
                        title: const Text('item2'),
                        data: 'item2',
                      ),
                      FormeListTileItem(
                        title: const Text('item3'),
                        data: 'item3',
                      ),
                      FormeListTileItem(
                        title: const Text('item4'),
                        data: 'item4',
                      ),
                      FormeListTileItem(
                        title: const Text('item5'),
                        data: 'item5',
                      ),
                    ],
                  ),
                  title: 'FormeSwitchGroup2',
                ),
                Example(
                  subTitle: 'split is 1, means ListTile like',
                  formeKey: key,
                  field: FormeRadioGroup<String>(
                    split: 1,
                    name: 'radio-group',
                    items: [
                      FormeListTileItem(
                        secondary: const Icon(Icons.hourglass_empty),
                        title: const Text('item1'),
                        data: 'item1',
                      ),
                      FormeListTileItem(
                        secondary: const Icon(Icons.hourglass_empty),
                        title: const Text('item2'),
                        data: 'item2',
                      ),
                    ],
                  ),
                  title: 'FormeRadioGroup',
                ),
                Example(
                  subTitle: 'split is 3, means three radios per line',
                  formeKey: key,
                  field: FormeRadioGroup<String>(
                    split: 3,
                    name: 'radio-group2',
                    items: [
                      FormeListTileItem(
                        title: const Text('item1'),
                        data: 'item1',
                      ),
                      FormeListTileItem(
                        title: const Text('item2'),
                        data: 'item2',
                      ),
                      FormeListTileItem(
                        title: const Text('item3'),
                        data: 'item3',
                      ),
                      FormeListTileItem(
                        title: const Text('item4'),
                        data: 'item4',
                      ),
                      FormeListTileItem(
                        title: const Text('item5'),
                        data: 'item5',
                      ),
                    ],
                  ),
                  title: 'FormeRadioGroup2',
                ),
              ];
            });
}
