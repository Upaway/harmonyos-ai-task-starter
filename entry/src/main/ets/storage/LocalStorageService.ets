import { common } from '@kit.AbilityKit';
import { preferences } from '@kit.ArkData';

export class LocalStorageService {
  private static readonly STORE_NAME: string = 'just_start_store';
  private static instance: LocalStorageService = new LocalStorageService();

  private preferencesInstance?: preferences.Preferences;
  private pendingStore?: Promise<preferences.Preferences>;

  static getInstance(): LocalStorageService {
    return LocalStorageService.instance;
  }

  private async getStore(context: common.Context): Promise<preferences.Preferences> {
    if (this.preferencesInstance) {
      return this.preferencesInstance;
    }

    if (!this.pendingStore) {
      const options: preferences.Options = {
        name: LocalStorageService.STORE_NAME
      };
      this.pendingStore = preferences.getPreferences(context, options).then((store: preferences.Preferences) => {
        this.preferencesInstance = store;
        return store;
      }).catch((error: Error) => {
        console.error('LocalStorageService getPreferences error:', error);
        this.pendingStore = undefined;
        throw error;
      });
    }

    return this.pendingStore;
  }

  async getString(context: common.Context, key: string, defaultValue: string): Promise<string> {
    try {
      const store: preferences.Preferences = await this.getStore(context);
      const result: string | number | boolean | Object = await store.get(key, defaultValue) as string | number | boolean | Object;
      return typeof result === 'string' ? result : defaultValue;
    } catch (error) {
      console.error('LocalStorageService getString error:', error);
      return defaultValue;
    }
  }

  async putString(context: common.Context, key: string, value: string): Promise<void> {
    try {
      const store: preferences.Preferences = await this.getStore(context);
      await store.put(key, value);
      await store.flush();
    } catch (error) {
      console.error('LocalStorageService putString error:', error);
    }
  }
}
