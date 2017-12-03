using UnityEngine;

namespace Isaura
{
    public class Composite : MonoBehaviour
    {
        [SerializeField] Texture _buffer;
        [SerializeField] Shader _shader;

        Material _material;

        void OnDestroy()
        {
            if (_material != null)
            {
                Destroy(_material);
                _material = null;
            }
        }

        void OnRenderImage(RenderTexture source, RenderTexture dest)
        {
            if (_material == null)
            {
                _material = new Material(_shader);
                _material.hideFlags = HideFlags.DontSave;
            }

            _material.SetTexture("_BufferTex", _buffer);

            Graphics.Blit(source, dest, _material, 0);
        }
    }
}
