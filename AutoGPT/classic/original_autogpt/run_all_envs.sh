#!/bin/bash

# 環境リスト
# env_names=("CartPole-v1" "Acrobot-v1" "MountainCar-v0" "Hopper-v5" "Humanoid-v5")
env_names=("CartPole-v1" "Acrobot-v1" "MountainCar-v0" "Hopper-v5" "Humanoid-v5" "Pendulum-v1" "LunarLander-v3" "CarRacing-v3" "BipedalWalker-v3" "Walker2d-v5" "Ant-v5" "Reacher-v5" "HalfCheetah-v5" "Swimmer-v5")

# conda環境を有効化
source /opt/anaconda3/etc/profile.d/conda.sh
conda activate metagpt

# すべての環境について繰り返し処理
for env_name in "${env_names[@]}"; do
  # フォルダ作成
  mkdir -p "$env_name"

  # フォルダに移動
  cd "$env_name" || exit 1

#   # conda環境を有効化
#   conda activate metagpt

  # プロンプトを作成
  prompt="There is a gym or gymnasium environment called $env_name, please determine whether to use gym or gymnasium and implement an agent that can play this game well. To minimize errors, use libraries for deep reinforcement learning and keep the implementation as simple as possible."

  # AutoGPTコマンドを実行
    # python3 -m autogpt --prompt "$prompt" --num-results 10 --num-epochs 10 --num-steps 1000 --num-sequences 10 --num-continuations 10 --num-batches 10 --batch-size 10 --learning-rate 5e-5 --output-file "output.json"
    python autogpt --prompt "$prompt"

  # 親フォルダに戻る
  cd ..

done