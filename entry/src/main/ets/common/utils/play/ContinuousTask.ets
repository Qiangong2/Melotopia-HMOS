import { BusinessError } from '@kit.BasicServicesKit';
import { backgroundTaskManager } from '@kit.BackgroundTasksKit';
import { WantAgent, wantAgent } from '@kit.AbilityKit';
import { LogUtil } from '@pura/harmony-utils';
import { getContext_ } from '../system/AppUtils';

/**
 * 长时任务
 */
const TAG = 'ContinuousTask'

class ContinuousTask {
  async startTask() {
    let wantAgentInfo: wantAgent.WantAgentInfo = {
      wants: [
        {
          bundleName: "cn.chenlvin.melotopia.hm",
          abilityName: "EntryAbility"
        }
      ],
      actionType: wantAgent.OperationType.START_ABILITY,
      requestCode: 0,
      actionFlags: [wantAgent.WantAgentFlags.UPDATE_PRESENT_FLAG]
    };

    wantAgent.getWantAgent(wantAgentInfo).then((wantAgentObj: WantAgent) => {
      backgroundTaskManager.startBackgroundRunning(getContext_(),
        backgroundTaskManager.BackgroundMode.AUDIO_PLAYBACK, wantAgentObj).then(async () => {
      }).catch((err: BusinessError) => {
        // LogUtil.error(TAG, `启动长时任务 Start Background Running 失败：Code - ${err.code}, Message - ${err.message}`)
      })
    })
  }

  async stopTask() {
    backgroundTaskManager.stopBackgroundRunning(getContext_()).then(() => {
    }).catch((err: BusinessError) => {
      LogUtil.error(TAG, `结束长时任务 Stop Background Running 失败：Code - ${err.code}, Message - ${err.message}`);
    })
  }
}

const conTask = new ContinuousTask()
export default conTask as ContinuousTask