import { useBackend, useSharedState } from '../backend';
import { Box, Stack, Tabs, Section, LabeledList, Button} from '../components';
import { Window } from '../layouts';

export const _LoadoutManager = (props, context) => {
  const { act, data } = useBackend(context);
  const {
    icon64,
    selected_loadout,
    loadout_tabs,
  } = data;

  const [selectedTabID, setSelectedTab] = useSharedState(context, 'tabs', loadout_tabs[0]?.id);
  const selectedTab = loadout_tabs.find(curTab => {
    return curTab.id === selectedTabID;
  });

  return (
    <Window
      title="Loadout Manager"
      width={900}
      height={620}>
      <Window.Content>
        <Stack grow vertical>
          <Stack.Item>
            <Section
              title="Loadout Categories"
              align="center" >
              <Tabs fluid align="center">
                {loadout_tabs.map(curTab => (
                  <Tabs.Tab
                    key={curTab.id}
                    selected={curTab.id === selectedTabID}
                    onClick={() => setSelectedTab(curTab.id)}>
                    {curTab.id}
                  </Tabs.Tab>
                ))}
              </Tabs>
            </Section>
          </Stack.Item>
          <Stack.Item>
            <Stack>
              <Stack.Item grow >
              { selectedTab && selectedTab.contents ? (
                <Section
                  title={`${selectedTab.id} Items`}
                  align="center"
                  fill
                  scrollable>
                  <LabeledList>
                    {selectedTab.contents.map(item => (
                      <LabeledList.Item
                        key={item.name}
                        label={item.name}
                        buttons={(
                          <Button.Checkbox
                            color="good"
                            align="left"
                            content="Select"
                            fluid
                            onClick={() => act('select_item', {
                              category: selectedTab.slot,
                              path: item.path,
                            })}/>)}>
                      </LabeledList.Item>
                    ))}
                  </LabeledList>
                </Section>
              ) : (
                <Section fill>
                  <Box>
                    No contents for selected tab.
                  </Box>
                </Section>
              )}
            </Stack.Item>
              <Stack.Item width="50%" align="center">
                <Section
                  title="Preview"
                  align="center"
                  fill>
                  <Box
                    as="img"
                    m={0}
                    src={`data:image/jpeg;base64,${icon64}`}
                    width="100%"
                    style={{
                      '-ms-interpolation-mode': 'nearest-neighbor',
                    }} />
                </Section>
              </Stack.Item>
            </Stack>
          </Stack.Item>
        </Stack>
      </Window.Content>
    </Window>
  );
};
