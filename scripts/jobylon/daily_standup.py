import requests
import json
from tasklib import TaskWarrior

SLACK_TOKEN = "xoxs-2245773731-426624826388-1269984472358-85af808a78881ce5d00eb8b54b799d83d66a85fd1b0b7f03f0672846405b3e6d"


class SlackClient(object):

    API_URL_CONVERSATIONS_HISTORY = "https://slack.com/api/conversations.history"
    API_URL_POST_MESSAGE = "https://slack.com/api/chat.postMessage"

    def __init__(self, token):
        self.token = token

    def send_slack_message(self, text, channel, thread_ts='' ):
        blocks = json.loads(
            '[{"block_id":"","elements":[{"elements":[{"text":"{text}","type":"text"}],"type":"rich_text_section"}],"type":"rich_text"}]'
        )
        blocks[0]['elements'][0]['elements'][0]['text'] = text
        data = {
            "blocks": blocks,
            "channel": channel,
            "thread_ts": thread_ts,
            "reply_broadcast": False,
            "mark_mentions_read": False,
        }
        headers = {
            "Authorization": f"Bearer {self.token}",
            "Content-type": "application/json; charset=utf-8",
        }
        response = requests.post(
            self.API_URL_POST_MESSAGE,
            headers=headers,
            data=json.dumps(data)
        )
        response_json = response.json()
        print(response_json['ok'])

    def get_last_message_id_in_channel(self, channel):
        data = {
            "channel": channel,
            "limit": 1,
        }
        headers = {
            "Authorization": f"Bearer {self.token}",
            "Content-type": "application/x-www-form-urlencoded",
        }
        response = requests.post(
            self.API_URL_CONVERSATIONS_HISTORY,
            headers=headers,
            data=data
        )
        response_json = response.json()
        return response_json["messages"][0]["ts"]


class TaskClient(object):
    PROJECT = "Jobylon"

    def __init__(self):
        self.client = TaskWarrior()

    def get_completed_tasks(self):
        tasks = self.client.tasks.filter(
            status='completed',
            project='Jobylon',
        )
        return tasks

    def get_completed_tasks__last_week(self):
        tasks = self.get_completed_tasks()
        return tasks.filter(end__after='today-1wk')

    def get_completed_tasks__yesterday(self):
        tasks = self.get_completed_tasks()
        return tasks.filter(end__after='today-1d')

#  slack_client = SlackClient(SLACK_TOKEN)
#  channel = "DCJQW3HD0"
#  thread_ts = slack_client.get_last_message_id_in_channel(channel)
#  slack_client.send_slack_message("not too bad", channel=channel, thread_ts=thread_ts)

client = TaskClient()
print(client.get_completed_tasks__yesterday())
