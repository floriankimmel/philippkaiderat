# PhilippKaider.at Astro Rebuild Plan

## Goal
Rebuild philippkaider.at using Astro with Blackspike template as base, replicating the tadejpogacar.com 4-column hover hero design + blog functionality.

## Reference Analysis

### Tadej Pogačar Site Structure
- **Homepage**: 4 vertical columns (100vh), shared background image changes on hover
- **Blog list**: Masonry grid, date badges (day/month), image cards with title overlay
- **Blog post**: Featured image, date badge, article content, social share buttons
- **Header**: Logo, nav (Homepage, About, Shop, Blog, Sponsors, Contact), social icons
- **Footer**: Multi-column links, social icons

### Blackspike Template Provides
- Astro 5 + Tailwind 4
- Modern CSS (scroll-linked animations, container queries)
- JSON content management
- Component-based architecture
- Image optimization (AVIF)

## Implementation Plan

### Phase 1: Setup
1. Clone repo `git@github.com:floriankimmel/philippkaiderat.git`
2. Initialize with Blackspike template: `npm create astro@latest -- --template blackspike/blackspike-astro-landing-page`
3. Install dependencies: `npm install`
4. Add i18n package: `npm install astro-i18next` (for DE/EN support)

### Phase 2: Homepage Hero (4-Column Hover)
Create `src/components/HeroGrid.astro`:
```
- 4 full-height columns using CSS Grid
- Each column: link with title + subtitle overlay
- Parent container holds background image
- JS: mouseenter/mouseleave changes parent background-image
- Transition: 0.2s cubic-bezier(0.68, -0.55, 0.27, 1.55)
```

Sections for Philipp (4 columns + Blog integration):
1. **ÜBER MICH / ABOUT** → /about
2. **BLOG / NEWS** → /blog
3. **PARTNER / SPONSORS** → /sponsors
4. **KONTAKT / CONTACT** → /contact

### i18n Support (German + English)
- Use `astro-i18n` or manual routing (`/de/`, `/en/`)
- Language switcher in header
- Content in both languages

### Phase 3: Blog System
Using Astro Content Collections:

1. Create `src/content/config.ts` - define blog schema
2. Create `src/content/blog/` - markdown files for posts
3. Create `src/pages/blog/index.astro` - blog list (masonry grid)
4. Create `src/pages/blog/[slug].astro` - single post template
5. Create `src/components/BlogCard.astro` - card with date badge + image

### Phase 4: Shared Components
Adapt from Blackspike + create:

1. `src/components/Header.astro` - logo, nav, social icons
2. `src/components/Footer.astro` - links, social icons, copyright
3. `src/components/SocialShare.astro` - share buttons for blog posts
4. `src/layouts/BaseLayout.astro` - wrap all pages

### Phase 5: Additional Pages
1. `/about` - About Philipp page
2. `/sponsors` - Partner/sponsor logos
3. `/contact` - Contact form/info

### Phase 6: Styling & Assets
1. Update Tailwind config with brand colors
2. Add Philipp's images (hero backgrounds, profile)
3. Add logo/favicon
4. Responsive: mobile → stacked columns

## File Structure
```
src/
├── components/
│   ├── HeroGrid.astro      # 4-column hover hero
│   ├── BlogCard.astro      # Blog list card
│   ├── Header.astro
│   ├── Footer.astro
│   └── SocialShare.astro
├── content/
│   ├── config.ts           # Content collection schema
│   └── blog/               # Blog posts (markdown)
├── layouts/
│   └── BaseLayout.astro
├── pages/
│   ├── index.astro         # Homepage with HeroGrid
│   ├── about.astro
│   ├── sponsors.astro
│   ├── contact.astro
│   └── blog/
│       ├── index.astro     # Blog list
│       └── [slug].astro    # Single post
└── styles/
    └── global.css
```

## Key Technical Details

### Hover Effect Implementation
```javascript
// In HeroGrid.astro
const hero = document.getElementById('hero-grid');
document.querySelectorAll('.hero-section').forEach(el => {
  el.addEventListener('mouseenter', () => {
    hero.style.backgroundImage = `url(${el.dataset.hoverBg})`;
  });
  el.addEventListener('mouseleave', () => {
    hero.style.backgroundImage = `url('${defaultBg}')`;
  });
});
```

### Blog Content Schema
```typescript
// src/content/config.ts
import { defineCollection, z } from 'astro:content';

const blog = defineCollection({
  schema: z.object({
    title: z.string(),
    date: z.date(),
    image: z.string(),
    excerpt: z.string().optional(),
  }),
});

export const collections = { blog };
```

## Verification
1. `npm run dev` - local development server
2. Check homepage hover effect works on all 4 sections
3. Navigate to /blog - verify grid displays posts
4. Click blog post - verify single post renders correctly
5. Test language switcher (DE/EN)
6. Test responsive layout on mobile
7. `npm run build` - verify production build succeeds

## Summary
- **Template**: Blackspike Astro (Astro 5 + Tailwind 4)
- **Hero**: 4-column hover effect (About, Blog, Partners, Contact)
- **Blog**: Astro Content Collections with masonry grid
- **i18n**: German + English with language switcher
- **Init**: Standard npm init
