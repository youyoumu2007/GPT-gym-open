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

## 結果

### MetaGPT

| 環境               | meta GPT | iterations | error | rewards | algorithm |
| ---------------- | -------- | ---------- | ----- | ------- | --------- |
| CartPole-v1      |          |            |       |         |           |
| Acrobot-v1       |          |            |       |         |           |
| MountainCar-v0   |          | 2          |       | -200    | PPO       |
| Hopper-v5        |          |            |       |         |           |
| Humanoid-v5      |          |            |       |         |           |
|                  |          |            |       |         |           |
| Pendulum-v1      |          | 1 → 2      |       | -163.01 | DDPG      |
| LunarLander-v3   |          |            |       |         |           |
| CarRacing-v3     |          | 3          |       | -59.64  | PPO       |
| BipedalWalker-v3 |          | 1          |       | -21.45  | PPO       |
| Walker2d-v5      |          |            |       |         |           |
| Ant-v5           |          |            |       |         |           |
| Reacher-v5       |          |            |       |         |           |
| HalfCheetah-v5   |          | 3          |       | -0.76   | PPO       |
| Swimmer-v5       |          |            |       |         |           |
|                  |          |            |       |         |           |
|                  |          |            |       |         |           |

| 環境               | meta GPT | 1回目           | error | 2回目           | 3回目    |     |
| ---------------- | -------- | ------------- | ----- | ------------- | ------ | --- |
| CartPole-v1      |          | x             |       | x             | x      |     |
| Acrobot-v1       |          | x             |       | x             | x      |     |
| MountainCar-v0   |          | x             |       | -200          | x e    |     |
| Hopper-v5        |          | x             |       | x             | x      |     |
| Humanoid-v5      |          | x             |       | x             | x      |     |
|                  |          |               |       |               |        |     |
| Pendulum-v1      |          | -1147.07(PPO) |       | -163.01(DDPG) | x e    |     |
| LunarLander-v3   |          | x             |       | x             | x      |     |
| CarRacing-v3     |          | x             |       | x             | -59.64 |     |
| BipedalWalker-v3 |          | -21.45        |       | x             | x e    |     |
| Walker2d-v5      |          | x             |       | x             | x      |     |
| Ant-v5           |          | x             |       | x             | x e    |     |
| Reacher-v5       |          | x             |       | x             | x      |     |
| HalfCheetah-v5   |          | x             |       | x             | -0.76  |     |
| Swimmer-v5       |          | x             |       | x             | x      |     |

ant-v5は自分でstep関数やreward, doneを実装していたが、すべてランダム　→ 実装はできていない と判定しました。
metaGPTは1回目で成功したものは2, 3回目を実行していないので、順番に詰めました。

### AutoGPT

| 環境               | Auto GPT | iterations | error | rewards | algorithm |
| ---------------- | -------- | ---------- | ----- | ------- | --------- |
| CartPole-v1      |          | 2          |       | 10.09   | DQN       |
| Acrobot-v1       |          | 1          |       | -500    | PPO       |
| MountainCar-v0   |          |            |       |         |           |
| Hopper-v5        |          |            |       |         |           |
| Humanoid-v5      |          | 1          |       | 318     | PPO       |
|                  |          |            |       |         |           |
| Pendulum-v1      |          | 1          |       | -148.04 | SAC       |
| LunarLander-v3   |          | 3          |       | 16.23   | PPO       |
| CarRacing-v3     |          | 1          |       | -23.55  | SAC       |
| BipedalWalker-v3 |          | 3          |       | -84.91  | PPO       |
| Walker2d-v5      |          | 3          |       | 285.62  | PPO       |
| Ant-v5           |          |            |       |         |           |
| Reacher-v5       |          |            |       |         |           |
| HalfCheetah-v5   |          |            |       |         |           |
| Swimmer-v5       |          | 1          |       | 22.08   | PPO       |

| 環境               | Auto GPT | 1回目     | 2回目     | 3回目    |     |
| ---------------- | -------- | ------- | ------- | ------ | --- |
| CartPole-v1      |          | x       | 10.09   | x n    |     |
| Acrobot-v1       |          | -500    | x e     | x      |     |
| MountainCar-v0   |          | x       | x n     | x      |     |
| Hopper-v5        |          | x       | x n     | x n    |     |
| Humanoid-v5      |          | 318     | 271.26  | x n    |     |
|                  |          |         |         |        |     |
| Pendulum-v1      |          | -148.04 | -157.36 | x e    |     |
| LunarLander-v3   |          | x       | x n     | 16.23  |     |
| CarRacing-v3     |          | -23.55  | x e     | x n    |     |
| BipedalWalker-v3 |          | x       | x n     | -84.91 |     |
| Walker2d-v5      |          | x       | x e     | 285.62 |     |
| Ant-v5           |          | x       | x e     | x e    |     |
| Reacher-v5       |          | x       | x n     | x n    |     |
| HalfCheetah-v5   |          | x       | x n     | x e    |     |
| Swimmer-v5       |          | 22.08   | x n     | x n    |     |

AutoGPTは3回目にすべての環境で実行しているので、3回目の結果を2回目に詰めた後で3回目の空白を埋めました。
