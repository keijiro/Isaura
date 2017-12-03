using UnityEngine;
using UnityEngine.Rendering.PostProcessing;

namespace Isaura
{
    [System.Serializable]
    [PostProcess(typeof(IsauraCompositeRenderer), PostProcessEvent.BeforeStack, "Isaura/Composite")]
    public sealed class IsauraComposite : PostProcessEffectSettings
    {
        public TextureParameter buffer = new TextureParameter();
    }

    public sealed class IsauraCompositeRenderer : PostProcessEffectRenderer<IsauraComposite>
    {
        public override void Render(PostProcessRenderContext context)
        {
            var sheet = context.propertySheets.Get(Shader.Find("Hidden/Isaura/Composite"));
            sheet.properties.SetTexture("_BufferTex", settings.buffer);
            context.command.BlitFullscreenTriangle(context.source, context.destination, sheet, 0);
        }
    }
}
