import 'package:flutter/material.dart';

import 'package:forme/forme.dart';
import 'package:forme_base_fields/forme_base_fields.dart';

import '../example.dart';
import '../forme_screen.dart';

class FormeExpansionListTileScreen extends FormeScreen {
  FormeExpansionListTileScreen({Key? key})
      : super(
            key: key,
            title: 'FormeExpansionListTile',
            builder: (context, key) {
              return [
                Example(
                  formeKey: key,
                  buttons: [
                    TextButton(
                        onPressed: () {
                          key.field('expansion').value = ['item7'];
                        },
                        child: const Text('select delete permission ')),
                    TextButton(
                        onPressed: () {
                          final FormeExpansionListTileState<String> state =
                              key.field('expansion')
                                  as FormeExpansionListTileState<String>;
                          state.getNode('item5')!.parent!.select(
                              selectAllChildren: true, selectParents: true);
                        },
                        child: const Text('select permission')),
                    TextButton(
                        onPressed: () {
                          final FormeExpansionListTileState<String> state =
                              key.field('expansion')
                                  as FormeExpansionListTileState<String>;
                          state
                              .getNode('item5')!
                              .parent!
                              .unselect(unselectAllChildren: true);
                        },
                        child: const Text('unselect permission')),
                    TextButton(
                        onPressed: () {
                          final FormeExpansionListTileState state =
                              key.field('expansion')
                                  as FormeExpansionListTileState;
                          state
                              .getNode('item5')!
                              .expand(expandAllChildren: true);
                        },
                        child: const Text('expand permission')),
                    TextButton(
                        onPressed: () {
                          (key.field('expansion')
                                  as FormeExpansionListTileState)
                              .getNode('item1')!
                              .collapse();
                        },
                        child: const Text('collapse user management'))
                  ],
                  field: FormeExpansionListTile<String>(
                    name: 'expansion',
                    expandAllChildrenWhenParentToggledOnUserInteraction: false,
                    items: [
                      FormeExpansionListTileItem.expansion(
                          secondary: const Icon(Icons.hourglass_empty),
                          title: const Text('user management'),
                          control:
                              FormeExpansionItemControl.checkbox(data: 'item1'),
                          childrenPadding: const EdgeInsets.only(left: 30),
                          children: [
                            FormeExpansionListTileItem.data(
                              secondary: const Icon(Icons.hourglass_empty),
                              title: const Text('add'),
                              control: FormeExpansionItemControl.checkbox(
                                  data: 'item2'),
                            ),
                            FormeExpansionListTileItem.data(
                              secondary: const Icon(Icons.hourglass_empty),
                              title: const Text('edit'),
                              control: FormeExpansionItemControl.checkbox(
                                  data: 'item3'),
                            ),
                            FormeExpansionListTileItem.expansion(
                                secondary: const Icon(Icons.hourglass_empty),
                                title: const Text('permission'),
                                childrenPadding:
                                    const EdgeInsets.only(left: 30),
                                children: [
                                  FormeExpansionListTileItem.data(
                                      secondary:
                                          const Icon(Icons.hourglass_empty),
                                      title: const Text('add'),
                                      control:
                                          FormeExpansionItemControl.checkbox(
                                              data: 'item5')),
                                  FormeExpansionListTileItem.data(
                                    secondary:
                                        const Icon(Icons.hourglass_empty),
                                    title: const Text('edit'),
                                    control: FormeExpansionItemControl.checkbox(
                                        data: 'item6'),
                                  ),
                                  FormeExpansionListTileItem.data(
                                    secondary:
                                        const Icon(Icons.hourglass_empty),
                                    title: const Text('delete'),
                                    control: FormeExpansionItemControl.checkbox(
                                        data: 'item7'),
                                  ),
                                ]),
                          ]),
                    ],
                  ),
                  title: 'FormeExpansionListTile',
                ),
              ];
            });
}
