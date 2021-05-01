import { useBackend, useSharedState } from '../backend';
import { Box, Button, Dimmer, Divider, Section, Stack, Tabs } from '../components';
import { Window } from '../layouts';

export const _LoadoutManager = (props, context) => {
  const { act, data } = useBackend(context);
  const {
    icon64,
    selected_loadout,
    loadout_tabs,
    mob_name,
    tutorial_status,
    tutorial_text,
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
        { !!tutorial_status && (
          <Dimmer>
            <Stack
              vertical
              align="center">
              <Stack.Item
                textAlign="center"
                fontSize="14px"
                style={{
                  'white-space': 'pre-wrap',
                }}>
                {tutorial_text}
              </Stack.Item>
              <Stack.Item>
                <Button
                  mt={1}
                  align="center"
                  fontSize="20px"
                  onClick={() => act('toggle_tutorial')}>
                    Okay.
                </Button>
              </Stack.Item>
            </Stack>
          </Dimmer>
        )}
        <Stack grow vertical>
          <Stack.Item>
            <Section
              title="Loadout Categories"
              align="center"
              buttons={(
                <Button
                  icon="info"
                  align="center"
                  content="Tutorial"
                  onClick={() => act('toggle_tutorial')}/>
                )}>
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
                  fill
                  buttons={(
                    <Button
                      icon="check-double"
                      color="good"
                      align="center"
                      content="Confirm and Close"
                      onClick={() => act('close_ui')}/>
                    )}>
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
                        <Divider/>
                    </Stack.Item>
                    <Stack.Item align="center">
                      <Stack>
                        <Stack.Item>
                          <Button
                            icon="chevron-left"
                            tooltip="Turn model preview to the left."
                            tooltipPosition="top"
                            onClick={() => act('rotate_dummy', {
                              dir: "left",
                            })}/>
                        </Stack.Item>
                        <Stack.Item>
                          <Button
                            icon="sync"
                            tooltip="Toggle viewing all \
                              preview directions at once."
                            tooltipPosition="top"
                            onClick={() => act('show_all_dirs')}/>
                        </Stack.Item>
                        <Stack.Item>
                          <Button
                            icon="chevron-right"
                            tooltip="Turn model preview to the right."
                            tooltipPosition="top"
                            onClick={() => act('rotate_dummy', {
                              dir: "right",
                            })}/>
                        </Stack.Item>
                      </Stack>
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
