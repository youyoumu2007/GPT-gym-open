# GPT-gym

## プロンプト
以下のプロンプトを用いました。``[env-name]``の部分は環境名に置き換えます。
```
There is a gym or gymnasium environment called [env-name], please determine whether to use gym or gymnasium and implement an agent that can play this game well. To minimize errors, use libraries for deep reinforcement learning and keep the implementation as simple as possible.
```

## metagpt
`run_all_envs.sh`内の`conda activate`の部分の環境名を自分の環境に合わせて変更してください。`env_names`に生成したい環境を指定してから`run_all_envs.sh`を実行すると、自動でフォルダを作成し、順次生成してくれます。

## AutoGPT
`classic/original_autogpt/autogpt.sh`を実行します。

## 評価

生成されたコードはほぼすべてStable-Baselines3を用いており、以下のコードで評価しました。

```python
from stable_baselines3 import PPO
# 使用するアルゴリズムによって from stable_baselines3 import DQN などに変更
from stable_baselines3.common.evaluation import evaluate_policy
import gym
# import gymnasium as gym

env = gym.make('[env_name]')
model = PPO.load("[model_path]")

mean_reward, std_reward = evaluate_policy(model, env, n_eval_episodes=100)
print(f"mean_reward:{mean_reward} +/- {std_reward}")
```
