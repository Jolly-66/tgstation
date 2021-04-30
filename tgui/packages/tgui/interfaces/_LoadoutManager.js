import { useBackend, useSharedState } from '../backend';
import { Box, Stack, Tabs, Section, LabeledList, Button} from '../components';
import { Window } from '../layouts';

export const _LoadoutManager = (props, context) => {
  const { act, data } = useBackend(context);
  const {
    icon64,
    selected_loadout,
    loadout_tabs,
    mob_name
  } = data;

  const [selectedTabID, setSelectedTab] = useSharedState(
    context, 'tabs', loadout_tabs[0]?.id);
  const selectedTab = loadout_tabs.find(curTab => {
    return curTab.id === selectedTabID;
  });

  return (
    <Window
      title="Loadout Manager"
      width={900}
      height={650}>
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
                  title={`Items: ${selectedTab.id}`}
                  fill
                  scrollable
                  buttons={(
                    <Button.Confirm
                      icon="times"
                      color="red"
                      align="center"
                      content="Clear All Items"
                      width={10}
                      onClick={() => act('clear_all_items')}/>
                    )}>
                  <Stack vertical>
                    {selectedTab.contents.map(item => (
                      <Stack.Item key={item.name}>
                        <Stack fontSize="15px">
                          <Stack.Item grow align="left">
                            {item.name}
                          </Stack.Item>
                          <Stack.Item>
                            <Button.Checkbox
                              checked={selected_loadout.includes(item.path)}
                              content="Select"
                              fluid
                              onClick={() => act('select_item', {
                                category: selectedTab.slot,
                                path: item.path,
                                doReset: selected_loadout.includes(item.path),
                              })}/>
                          </Stack.Item>
                        </Stack>
                      </Stack.Item>
                    ))}
                  </Stack>
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
                  title={`Preview: ${mob_name}`}
                  align="center"
                  fill>
                  <Stack vertical>
                    <Stack.Item>
                      <Box
                        as="img"
                        m={0}
                        src={`data:image/jpeg;base64,${icon64}`}
                        width="100%"
                        style={{
                          '-ms-interpolation-mode': 'nearest-neighbor',
                        }} />
                    </Stack.Item>
                    <Stack.Item>
                      <Button
                        icon="chevron-left"
                        tooltip="Turn model left."
                        tooltipPosition="top"
                        onClick={() => act('rotate_dummy', {
                          dir: "left",
                        })}/>
                      <Button
                        icon="sync"
                        tooltip="Enable all directions."
                        tooltipPosition="top"
                        onClick={() => act('show_all_dirs')}/>
                      <Button
                        icon="chevron-right"
                        tooltip="Turn model right."
                        tooltipPosition="top"
                        onClick={() => act('rotate_dummy', {
                          dir: "right",
                        })}/>
                    </Stack.Item>
                  </Stack>
                </Section>
              </Stack.Item>
            </Stack>
          </Stack.Item>
        </Stack>
      </Window.Content>
    </Window>
  );
};
