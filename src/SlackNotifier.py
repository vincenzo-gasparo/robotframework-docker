import requests
import json
import re
import copy

header_block = {"type": "header",
                "text": {
                    "type": "plain_text",
                    "text": "",
                    "emoji": True
                }}
divider_block = {"type": "divider"}
section_block = {
                "type": "section",
                "text": {
                    "type": "mrkdwn",
                    "text": ""
                }
            }
test_result_block = {
			"type": "section",
			"text": {
				"text": "_testname_",
				"type": "mrkdwn"
			},
			"fields": [
				{
					"type": "mrkdwn",
					"text": "*Status*:"
				},
				{
					"type": "mrkdwn",
					"text": "*Tags*:"
				},
				{
					"type": "plain_text",
					"text": "_status_"
				},
				{
					"type": "plain_text",
					"text": "_tags_"
				}
			]
		}

class SlackNotifier:
    ROBOT_LISTENER_API_VERSION = 3
    SLACK_URL_ROOT = "https://hooks.slack.com/services/"

    def __init__(self, slack_id, show_documentation=True):
        self.url = self.SLACK_URL_ROOT + slack_id
        self.show_documentation = show_documentation
        self._init_slack_message()

    def _init_slack_message(self):
        self.slack_message = {
            'blocks': []
        }

    def end_test(self, data, result):
        if not result.passed:
            self._init_slack_message()
            title = "*Test _'{}'_*:".format(result.longname)
            tags = ", ".join(data.tags)
            self.append_block(self.new_test_result(title, "FAILED :x:", tags))
            self.append_block(self.new_section('*Message*: {}'.format(result.message)))
            self.append_block(divider_block)
            self.append_block(divider_block)
            self.send_payload()
        else:
            pass

    def end_suite(self, data, result):
        self._init_slack_message()
        self.append_block(self.new_header("Suite '{}':".format(result.name)))
        self.append_block(self.new_header(result.statistics.message))
        # self.send_payload()

    def append_block(self, block):
        self.slack_message['blocks'].append(block)

    def new_section(self, text):
        section = copy.deepcopy(section_block)
        section['text']['text'] = text
        return section

    def new_header(self, text):
        section = copy.deepcopy(header_block)
        section['text']['text'] = text
        return section

    def new_test_result(self, test_name, status, tags):
        if not tags:
            tags = "None"
        section = copy.deepcopy(test_result_block)
        section['text']['text'] = test_name
        section['fields'][2]['text'] = status
        section['fields'][3]['text'] = tags
        return section

    def send_payload(self):
        requests.post(self.url, data=json.dumps(self.slack_message))
    
    def log_file(self, path):
        self.send_payload()
